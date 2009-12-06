From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: io-plugin does not call start callback function
Date: Sun, 06 Dec 2009 16:12:14 +0100
Message-ID: <4B1BC9CE.7040305@gmail.com>
References: <4B17A5CC.5050906@gmail.com> <4B17DE74.6@gmail.com>
	<358341420912040013m526a834bl968668da7b9f3c07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 5802D10380F
	for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2009 16:12:24 +0100 (CET)
In-Reply-To: <358341420912040013m526a834bl968668da7b9f3c07@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raul Xiong <raulxiong@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Raul,

Raul Xiong wrote:
> Hi Stefan
> 
> This is because your pointer callback function is not implemented properly.
> "pointer" callback function should return the right position of the
> playback/capture buffer, apps over alsa framework will call
> snd_pcm_avail_update to get the position.
> Also, you should call snd_pcm_ioplug_set_param_minmax in your
> play_hw_constraint function to define the buffer size relevant parameters.


Well, I did what you suggested but the start() callback is still not called:

$ aplay -D play test_8khz_16LE_mono.wav
Playing WAVE 'test_8khz_16LE_mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
snd_pcm_play_hw_params:84 24610 
snd_pcm_play_prepare:71 24610 hw_ptr -> 0
snd_pcm_play_pointer:54 24610 ptr: 0
snd_pcm_play_transfer:63 24610 aborting with -EINVAL ...
aplay: pcm_write:1442: write error: Invalid argument


Also, when transferring PCM samples from the ALSA buffer to somewhere else, it seems logical to me that the initial value of the hw_ptr has to be 0, right ?
As you can see above, the situation is still exactly the same and the start callback is never called at all.

The code for the plugin is below.

cheers,
stefan



#include <stdio.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pthread.h>
#include <time.h>
#include <alsa/asoundlib.h>
#include <alsa/pcm_external.h>

#define FILE_PERM	0644
#define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))

#define DEBUG
#ifdef DEBUG
#define DBG(f, ...) \
    fprintf(stderr, "%s:%i %i "f"\n", __FUNCTION__, __LINE__, getpid(), ## __VA_ARGS__);
#else
#define DBG(f, ...)
#endif

struct play_info {
	snd_pcm_ioplug_t io;
	char *filename;
	int file_fd;
	snd_pcm_sframes_t hw_ptr;
	snd_pcm_hw_params_t *hw_params;
};

static int snd_pcm_play_close(snd_pcm_ioplug_t *io)
{
	DBG("");
	return 0;
}

static int snd_pcm_play_start(snd_pcm_ioplug_t *io)
{
	DBG("");
	return 0;
}

static int snd_pcm_play_stop(snd_pcm_ioplug_t *io)
{
	DBG("");
	return 0;
}

static snd_pcm_sframes_t snd_pcm_play_pointer(snd_pcm_ioplug_t *io)
{
	struct play_info *data = io->private_data;
	
	DBG("ptr: %lu", data->hw_ptr);
	return data->hw_ptr;
}

static snd_pcm_sframes_t snd_pcm_play_transfer(snd_pcm_ioplug_t *io,
			const snd_pcm_channel_area_t *areas,
			snd_pcm_uframes_t offset,
			snd_pcm_uframes_t size)
{
	DBG("aborting with -EINVAL ...");
	return -EINVAL;
}

static int snd_pcm_play_prepare(snd_pcm_ioplug_t *io)
{
	struct play_info *data = io->private_data;
	
	DBG("hw_ptr -> 0");
	data->hw_ptr=0;

	return 0;
}

static int snd_pcm_play_hw_params(snd_pcm_ioplug_t *io,
                    snd_pcm_hw_params_t *params)
{
	snd_pcm_access_t access_list[] = { SND_PCM_ACCESS_RW_INTERLEAVED };
	unsigned int format_list[] = { SND_PCM_FORMAT_S16 };
	int err;
	
	DBG("");

    /* access type */
    err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
                    ARRAY_SIZE(access_list), access_list);
    if (err < 0)
        return err;

    /* supported formats */
    err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
                    ARRAY_SIZE(format_list), format_list);
    if (err < 0)
        return err;

    /* supported channels */
    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_CHANNELS,
                            1, 1);
    if (err < 0)
        return err;

    /* supported rate */
    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
                            8000, 8000);
    if (err < 0)
        return err;

    /* supported block size */
    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
                        156*2, 164*2);
    if (err < 0)
        return err;

    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
                                    2, 200);
    if (err < 0)
        return err;

	return 0;
}

static int snd_pcm_play_poll_descriptors_count(snd_pcm_ioplug_t *io)
{
		DBG("");
	    return 1;
}


static int snd_pcm_play_poll_descriptors(snd_pcm_ioplug_t *io,
                    struct pollfd *pfd, unsigned int space)
{
	DBG("");
	return 1;
}

static int snd_pcm_play_poll_revents(snd_pcm_ioplug_t *io,
                    struct pollfd *pfds, unsigned int nfds,
	                unsigned short *revents)
{
	DBG("");
	return 0;
}

static int snd_pcm_play_delay(snd_pcm_ioplug_t *io, snd_pcm_sframes_t *delayp)
{
	DBG("");
	return 0;
}

static snd_pcm_ioplug_callback_t play_pcm_callback = {
    .close = snd_pcm_play_close,
    .start = snd_pcm_play_start,
    .stop = snd_pcm_play_stop,
    .pointer = snd_pcm_play_pointer,
    .transfer = snd_pcm_play_transfer,
	.prepare = snd_pcm_play_prepare,
	.hw_params = snd_pcm_play_hw_params,
	.poll_descriptors_count = snd_pcm_play_poll_descriptors_count,
	.poll_descriptors = snd_pcm_play_poll_descriptors,
	.poll_revents = snd_pcm_play_poll_revents,
	.delay = snd_pcm_play_delay,
};

static int play_hw_constraint(struct play_info * pcm)
{
	snd_pcm_ioplug_t *io = &pcm->io;


	static const snd_pcm_access_t access_list[] = {
		SND_PCM_ACCESS_RW_INTERLEAVED
	};
	static const unsigned int formats[] = {
		SND_PCM_FORMAT_S16_LE,
	};

	int err;

	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
					    ARRAY_SIZE(access_list),
					    access_list);
	if (err < 0)
	{
		SNDERR("cannot set HW access constraint list: %s", snd_strerror(err));
		return err;
	}

	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
					    ARRAY_SIZE(formats), formats);
	if (err < 0)
	{
		SNDERR("cannot set HW format constraint list: %s", snd_strerror(err));
		return err;
	}

	return 0;
}

SND_PCM_PLUGIN_DEFINE_FUNC(play)
{
	snd_config_iterator_t i, next;
	const char *filename=NULL;
	int err;
	struct play_info *play=NULL;

	if (stream != SND_PCM_STREAM_PLAYBACK)
	{
		SNDERR("play plugin can only be used for playback\n");
		return -1;
	}
	
	snd_config_for_each(i, next, conf) {
		snd_config_t *n = snd_config_iterator_entry(i);
		const char *id;
		if (snd_config_get_id(n, &id) < 0)
			continue;

		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0 || strcmp(id, "hint") == 0)
			continue;

		if (strcmp(id, "filename") == 0) {
			if (snd_config_get_type(n) != SND_CONFIG_TYPE_STRING)
			{
				SNDERR("invalid type for %s\n", id);
				return -EINVAL;
			}

			if (snd_config_get_string(n, &filename)<0)
			{
				SNDERR("could not get filename for %s\n", id);
				return -EINVAL;
			}
			continue;
		}

		SNDERR("Unknown field %s", id);
		return -EINVAL;
	}

	if (!filename)
	{
		SNDERR("no filename defined or play plugin\n");
		return -EINVAL;
	}

	if ((play = calloc(1, sizeof(*play))) == NULL)
		return -ENOMEM;

	play->io.version = SND_PCM_IOPLUG_VERSION;
	play->io.name = "ALSA play Plugin";
	play->io.callback = &play_pcm_callback;
	play->io.private_data = play;
	play->io.mmap_rw = 0;

	if ((err = snd_pcm_ioplug_create(&play->io, name, stream, mode))<0)
	{
        free(play);
        return err;
    }
	
	err = play_hw_constraint(play);
	if (err < 0) {
		snd_pcm_ioplug_delete(&play->io);
		free(play);
		return err;
	}
	
	*pcmp = play->io.pcm;

	return err;
}

SND_PCM_PLUGIN_SYMBOL(play);
