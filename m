From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Clicking issues with the output of an Onyx
	Blackbird
Date: Sun, 16 Oct 2016 03:58:24 +0900
Message-ID: <243b6b79-4da6-f096-748a-e435249e8014@sakamocchi.jp>
References: <CACF1cz+wRmDQVN6aDsFpPndSyAygwgHaQHyjxu0hcjh3vx+Txw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 86651261740
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 20:58:31 +0200 (CEST)
In-Reply-To: <CACF1cz+wRmDQVN6aDsFpPndSyAygwgHaQHyjxu0hcjh3vx+Txw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jordi Torres <clubmajo@yahoo.es>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 13 2016 22:51, Jordi Torres wrote:
> I tested all DICE outputs but as this DAW uses a non-numeric
> terminology, it have been a little complicated to check all outputs
>
> This is a reference of how ouputs are routed to connectors:
>
> Front outputs:
>
> Phone 1 & Switch in MON position -> InS0:01 + InS0:02
> Phone 1 & Switch in PH1 position -> InS0:05 + InS0:06
> Phone 2 & Switch in MON position -> InS0:01 + InS0:02
> Phone 2 & Switch in PH2 position -> InS0:07 + InS0:08
>
> Back outputs:
>
> ALT out L-> InS0:03
> ALT out R-> InS0:04
> MAIN out L -> InS0:01
> MAIN out R -> InS0:02
> MON out L -> InS0:01
> MON out R -> InS0:02
>
> I tested ADAT looped (from output ADAT to input ADAT) and clicks too
> I tested if clicks when DICE routes one input to one output and it
> doesn't click.
> I didn't test Inserts but I supouse that use InS0:01 & InS0:02

In most models with Dice II/Jr/Mini, digital interface (SPDIF/TOSLINK
and ADAT) in/out is just bypass to/from corresponding data channels in
IEEE 1394 isochronous packets. No multiplexing with the other data
channels. Furthermore, The data channels corresponding to digital
interfaces is in rear position inner a packet.

For these natures, I use the loopbacked digital interface in/out to
investigate this driver issue. The program in last of this message is a
part of my test programs for this issue.

According to the logs you sent, ALSA Dice driver adds one PCM device for
capture and _two_ PCM devices for playback to your units. So you need to
modify the program for your unit.

I think that capture 'pcm.hw:1,0,0' and playback 'pcm.hw:1,1,0' include
ADAT channels. It's better to show us the output from
'/proc/asound/card1/dice' so that we can get to know channel formations
of your unit.

In my case:
$ gcc -o test test.c -l pthread -l asound
$ ./test pcm,hw:1,0,0 48000

-------- 8< --------

#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>

#include <pthread.h>

#include <alsa/asoundlib.h>

static const char *node;
static unsigned int rate;

static int set_params(snd_pcm_t *handle, int rate, snd_pcm_format_t format,
                      unsigned int *ch)
{
    snd_pcm_hw_params_t *params;
    int err;

    snd_pcm_hw_params_alloca(&params);

    err = snd_pcm_hw_params_any(handle, params);
    if (err < 0) {
        printf("snd_pcm_hw_params_any()\n");
        return err;
    }

    err = snd_pcm_hw_params_set_access(handle, params,
                       SND_PCM_ACCESS_RW_INTERLEAVED);
    if (err < 0) {
        printf("snd_pcm_hw_params_set_access()\n");
        return err;
    }

    err = snd_pcm_hw_params_set_rate(handle, params, rate, 0);
    if (err < 0) {
        printf("snd_pcm_hw_params_set_rate()\n");
        return err;
    }

    err = snd_pcm_hw_params_set_format(handle, params, format);
    if (err < 0) {
        printf("snd_pcm_hw_params_set_format()\n");
        return err;
    }

    err = snd_pcm_hw_params(handle, params);
    if (err < 0) {
        printf("snd_pcm_hw_params()\n");
        return err;
    }

    err = snd_pcm_hw_params_get_channels(params, ch);
    if (err < 0)
        printf("snd_pcm_hw_params_get_channels()\n");

    return err;
}

static int receive_pcm_s32(snd_pcm_t *handle, snd_pcm_format_t format,
                           unsigned int chs)
{
    uint32_t *buf, curr[2], expected[2];
    snd_pcm_sframes_t frames;
    unsigned int i;
    unsigned int count;
    unsigned int phase, drops;
    int err = 0;

    buf = malloc(sizeof(uint32_t) * chs * 0xff);
    if (buf == NULL)
        return -ENOMEM;

    count = 0;
    while (1) {
        frames = snd_pcm_readi(handle, buf, 0xff);
        if (frames < 0) {
            printf("snd_pcm_readi(): %s\n", snd_strerror(frames));
            err = snd_pcm_recover(handle, frames, 0);
            if (err < 0) {
                printf("snd_pcm_recover(): %s\n", snd_strerror(err));
                err = frames;
                break;
            }
            continue;
        }

        for (i = 0; i < frames; i++) {
            curr[0] = buf[chs * i + chs - 2];
            curr[1] = buf[chs * i + chs - 1];

            /* Unexpected PCM samples are in this PCM frame. */
            if (curr[0] != expected[0] || curr[1] != expected[1]) {
                if (count - phase > 10000) {
                    printf("%08d %08d: %08x %08x %08x %08x\n",
                           count - phase, drops,
                           curr[0], curr[1],
                           expected[0], expected[1]);
                    phase = count;
                    drops = 0;
                } else {
                    drops += 1;
                }
            }

            expected[0] = curr[0] + 0x100;
            if (expected[0] > 0xffff0000)
                expected[0] = 0;
            expected[1] = curr[1] + 0x100;
            if (expected[1] > 0xffff0000)
                expected[1] = 0;
            count += 1;
        }
    }

    free(buf);
    return err;
}

static void *receive_samples(void *arg)
{
    snd_pcm_t *handle = NULL;
    unsigned int chs;
    int err;

    err = snd_pcm_open(&handle, node, SND_PCM_STREAM_CAPTURE, 0);
    if (err < 0) {
        printf("snd_pcm_open(): %s\n", snd_strerror(err));
        goto end;
    }

    err = set_params(handle, rate, SND_PCM_FORMAT_S32, &chs);
    if (err < 0)
        goto end;

    err = receive_pcm_s32(handle, SND_PCM_FORMAT_S32, chs);
    if (err < 0)
        goto end;

    err = snd_pcm_hw_free(handle);
    if (err < 0)
        printf("snd_pcm_hw_free(): %s\n", snd_strerror(err));
end:
    if (handle != NULL)
        snd_pcm_close(handle);

    pthread_exit(NULL);
}

static int transfer_pcm_s32(snd_pcm_t *handle, snd_pcm_format_t format,
                            unsigned int chs)
{
    unsigned int most;
    unsigned int medium;
    unsigned int least;
    unsigned int ch;
    uint32_t *buf, sample;
    snd_pcm_sframes_t frames;
    int err = 0;

    buf = malloc(sizeof(uint32_t) * 0xff * chs);
    if (buf == NULL)
        return -ENOMEM;

    sample = 0;
    for (most = 0x00; most < 0xff; most++) {
        for (medium = 0x00; medium < 0xff; medium++) {
            /* Generate PCM frames for this iteration. */
            for (least = 0; least < 0xff; least++)  {
                sample += 1;
                if (sample > 0x00ffffff)
                    sample = 0;
                for (ch = 0; ch < chs; ch++)
                    buf[least * chs + ch] = sample << 8;
            }

            frames = snd_pcm_writei(handle, buf, 0xff);
            if (frames < 0) {
                printf("snd_pcm_writei(): %s\n", snd_strerror(frames));
                err = snd_pcm_recover(handle, frames, 0);
                if (err < 0) {
                    printf("snd_pcm_recover(): %s\n", snd_strerror(err));
                    err = frames;
                    break;
                }
                continue;
            }
        }
    }


    free(buf);
    return err;
}

int main(int argc, const char *argv[])
{
    snd_pcm_t *handle = NULL;
    unsigned int chs;
    pthread_t thread;
    int err;

    if (argc != 3) {
        printf("Two arguments are required.\n");
        printf("    PCM node in ALSA runtime configuration.\n");
        printf("    sampling rate.\n");
        return EXIT_FAILURE;
    }

    node = argv[1];
    rate = strtol(argv[2], NULL, 10);

    err = snd_pcm_open(&handle, node, SND_PCM_STREAM_PLAYBACK, 0);
    if (err < 0) {
        printf("snd_pcm_open(): %s", snd_strerror(err));
        goto end;
    }

    err = set_params(handle, rate, SND_PCM_FORMAT_S32, &chs);
    if (err < 0)
        goto end;

    err = pthread_create(&thread, NULL, receive_samples, NULL);
    if (err != 0)
        goto end;

    err = transfer_pcm_s32(handle, SND_PCM_FORMAT_S32, chs);
    if (err < 0)
        goto end;

    err = snd_pcm_drain(handle);
    if (err < 0) {
        printf("snd_pcm_drain(): %s", snd_strerror(err));
        goto end;
    }

    err = snd_pcm_hw_free(handle);
    if (err < 0)
        printf("snd_pcm_hw_free(): %s", snd_strerror(err));
end:
    if (handle != NULL)
        snd_pcm_close(handle);
    exit(EXIT_SUCCESS);
}


Regards

Takashi Sakamoto
