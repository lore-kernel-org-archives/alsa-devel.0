From: Andrew Eikum <aeikum@codeweavers.com>
Subject: hw_params ignores ioplug's buffer size requirements
Date: Tue, 7 Aug 2012 09:32:11 -0500
Message-ID: <20120807143211.GM2424@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E50F265B4E
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 17:27:40 +0200 (CEST)
Received: from foghorn.codeweavers.com ([216.251.189.130])
 by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.72) (envelope-from <aeikum@codeweavers.com>)
 id 1SykpQ-0004gL-7e
 for alsa-devel@alsa-project.org; Tue, 07 Aug 2012 09:32:12 -0500
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi folks,

I've got either a bug or a misunderstanding in how ALSA handles
ioplugs that provide hw_params restrictions. My understanding is that
the snd_pcm_ioplug_set_param_* functions are supposed to restrict
which hw_params settings a client may set. This seems to work for at
least access and format. But I noticed that it's broken for
buffer_bytes and periods at least.

Attached is two source files demonstrating the problem. alsa-example.c
is a dead-simple ioplug module. It sets some hw_params restrictions,
and does basically nothing else. The important thing to notice is that
it sets /only one/ allowable period size, period count, and buffer
size, all of which are compatible with each other (256 byte period *
8 periods == 2048 byte buffer size).

There is also test client, alsa-test.c, which attempts to violate
those hw_params restrictions, and succeeds! The eventual call to the
ioplug's example_hw_params() callback gets an invalid buffer_size
parameter (it happens to be 512).

Here is the output when run on my Arch Linux with alsa-lib 1.0.25:

[aeikum@aeikum ioplug_buffer_bytes]$ ./alsa-test 
ALSA-example: Opening
bytes: 512
ALSA-example: hw_params: 512
TEST FAILURE: buffer_size != 8812: 512
ALSA-example: stop
ALSA-example: close
[aeikum@aeikum ioplug_buffer_bytes]$ 

Am I misunderstanding the snd_pcm_ioplug_set_param_* methods, or is
this a bug? I am seeing this behavior in the wild with a pulseaudio
client that ignores my hw_params restrictions.

Thanks for any insight,
Andrew

--SLDf9lqlvOQaIe6s
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="alsa-example.c"

/* build with:
 *   $ gcc -fPIC -DPIC -c -Wall -Wno-unused-variable -Wno-unused-function alsa-example.c
 *   $ gcc -Wl,--no-undefined -shared -fPIC -lasound -o libasound_module_pcm_example.so alsa-example.o -lc
 *   # cp libasound_module_pcm_example.so /usr/lib/alsa-lib/
 * create an 'example' PCM in asoundrc of type 'example'
 * test with attached alsa-test.c
 */

#include <alsa/asoundlib.h>
#include <alsa/pcm_external.h>

#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>
#include <sys/time.h>

struct example_pcm {
    snd_pcm_ioplug_t io;
};

static int example_start(snd_pcm_ioplug_t *io)
{
    struct example_pcm *sp_pcm = io->private_data;
    fprintf(stderr, "ALSA-example: start\n");
    return 0;
}

static int example_stop(snd_pcm_ioplug_t *io)
{
    struct example_pcm *sp_pcm = io->private_data;
    fprintf(stderr, "ALSA-example: stop\n");
    return 0;
}

static snd_pcm_sframes_t example_pointer(snd_pcm_ioplug_t *io)
{
    struct example_pcm *sp_pcm = io->private_data;
    fprintf(stderr, "ALSA-example: pointer\n");
    return 0;
}

static snd_pcm_sframes_t example_transfer(snd_pcm_ioplug_t *io,
        const snd_pcm_channel_area_t *areas,
        snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
{
    struct example_pcm *sp_pcm = io->private_data;
    fprintf(stderr, "ALSA-example: transfer\n");
    return size;
}

static int example_close(snd_pcm_ioplug_t *io)
{
    struct example_pcm *sp_pcm = io->private_data;
    fprintf(stderr, "ALSA-example: close\n");
    return 0;
}

static int example_hw_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params)
{
    struct example_pcm *sp_pcm = io->private_data;

    fprintf(stderr, "ALSA-example: hw_params\n");

    if(io->buffer_size != 8812)
        fprintf(stderr, "TEST FAILURE: buffer_size != 8812: %lu\n", io->buffer_size);
    else
        fprintf(stderr, "TEST SUCCESS: buffer_size == 8812: %lu\n", io->buffer_size);

    return 0;
}

static const snd_pcm_ioplug_callback_t example_playback_callback = {
    example_start, /* start, required */
    example_stop, /* stop, required */
    example_pointer, /* pointer, required */
    example_transfer, /* transfer, optional */
    example_close, /* close, optional */
    example_hw_params, /* hw_params, optional */
    NULL, /* hw_free, optional */
    NULL, /* sw_params, optional */
    NULL, /* prepare, optional */
    NULL, /* drain, optional */
    NULL, /* pause, optional */
    NULL, /* resume, optional */
    NULL, /* poll_descriptors_count, optional */
    NULL, /* poll_descriptors, optional */
    NULL, /* poll_revents, optional */
    NULL, /* dump, optional */
    NULL/* delay, optional */
};

static int example_set_hw_params(snd_pcm_ioplug_t *io)
{
    static const snd_pcm_access_t access_list[] = {
        SND_PCM_ACCESS_RW_INTERLEAVED
    };

    static const unsigned int format_list[] = {
        SND_PCM_FORMAT_S16
    };

    int err;

    if((err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
                    sizeof(access_list) / sizeof(*access_list), access_list)) < 0)
        return err;

    if((err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
                    sizeof(format_list) / sizeof(*format_list), format_list)) < 0)
        return err;

    if((err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
                    44100, 44100)) < 0)
        return err;

    if((err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_CHANNELS,
                    2, 2)) < 0)
        return err;

    /* 8 * 256 = 2048 */
    if((err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
                    256,256)) < 0)
        return err;

    if((err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
                    8, 8)) < 0)
        return err;

    if((err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_BUFFER_BYTES,
                    2048, 2048)) < 0)
        return err;

    return 0;
}

int _snd_pcm_example_open(snd_pcm_t **pcmp, const char *name, snd_config_t *root,
        snd_config_t *conf, snd_pcm_stream_t stream, int mode)
{
    struct example_pcm *sp_pcm;
    int err;

    fprintf(stderr, "ALSA-example: Opening\n");

    sp_pcm = malloc(sizeof(*sp_pcm));
    if(!sp_pcm)
        return -ENOMEM;
    memset(sp_pcm, 0, sizeof(*sp_pcm));

    sp_pcm->io.version = SND_PCM_IOPLUG_VERSION;
    sp_pcm->io.name = "example Protocol Plugin";
    sp_pcm->io.callback = &example_playback_callback;
    sp_pcm->io.private_data = sp_pcm;

    err = snd_pcm_ioplug_create(&sp_pcm->io, name, stream, mode);
    if(err){
        free(sp_pcm);
        return err > 0 ? -err : err;
    }

    err = example_set_hw_params(&sp_pcm->io);
    if(err){
        snd_pcm_ioplug_delete(&sp_pcm->io);
        free(sp_pcm);
        return err;
    }

    *pcmp = sp_pcm->io.pcm;

    return 0;
}

SND_PCM_PLUGIN_SYMBOL(example);

--SLDf9lqlvOQaIe6s
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="alsa-test.c"

/* to build:
 *   $ gcc -Wall -o alsa-test alsa-test.c -lasound
 */

#include <alsa/asoundlib.h>

int main(int argc, char **argv)
{
    snd_pcm_t *pcm;
    snd_pcm_hw_params_t *hw_params;
    unsigned int rate;
    snd_pcm_uframes_t bytes;
    int err;

    if((err = snd_pcm_open(&pcm, "example", SND_PCM_STREAM_PLAYBACK, 0) < 0)){
        fprintf(stderr, "snd_pcm_open: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    if((err = snd_pcm_hw_params_malloc(&hw_params)) < 0){
        fprintf(stderr, "snd_pcm_hw_params_malloc: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    if((err = snd_pcm_hw_params_any(pcm, hw_params) < 0)){
        fprintf(stderr, "snd_pcm_hw_params_any: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    if((err = snd_pcm_hw_params_set_access(pcm, hw_params,
                    SND_PCM_ACCESS_RW_INTERLEAVED) < 0)){
        fprintf(stderr, "snd_pcm_hw_params_set_access: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    if((err = snd_pcm_hw_params_set_format(pcm, hw_params,
                    SND_PCM_FORMAT_S16_LE) < 0)){
        fprintf(stderr, "snd_pcm_hw_params_set_format: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    rate = 44100;
    if((err = snd_pcm_hw_params_set_rate_near(pcm, hw_params, &rate, NULL)) < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_rate_near: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    if((err = snd_pcm_hw_params_set_channels(pcm, hw_params, 2)) < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_channels: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    bytes = 512;
    if((err = snd_pcm_hw_params_set_buffer_size_near(pcm, hw_params, &bytes)) < 0){
        fprintf(stderr, "snd_pcm_hw_params_set_buffer_size_near: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }
    fprintf(stderr, "bytes: %lu\n", bytes);

    if((err = snd_pcm_hw_params(pcm, hw_params)) < 0){
        fprintf(stderr, "snd_pcm_hw_params: %d (%s)\n", err, snd_strerror(err));
        return 1;
    }

    snd_pcm_hw_params_free(hw_params);
    snd_pcm_close(pcm);

    return 0;
}

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--SLDf9lqlvOQaIe6s--
