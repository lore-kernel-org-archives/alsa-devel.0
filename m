From: Shane Loretz <a10.shane@gmail.com>
Subject: Segmentation fault during snd_pcm_prepare()
Date: Tue, 14 May 2013 21:47:57 -0700
Message-ID: <CAJAps6CVLcknWGDZrbewfTyUS3ra7tmwtv3oK0NHWBbqQY8dOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f46.google.com (mail-da0-f46.google.com
 [209.85.210.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 583A826109E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:47:58 +0200 (CEST)
Received: by mail-da0-f46.google.com with SMTP id e20so732460dak.33
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 21:47:57 -0700 (PDT)
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

I'm interested in writing an application using alsa. I've chosen to
explore the library by writing a program to echo sound data from a
microphone back to my speakers.

I'm only interested in mono sound.

When running this program, the first call to snd_pcm_readi() fails,
and a segmentation fault occurs inside of the snd_pcm_prepare()
function according to a backtrace from gdb. I suspect I'm not
allocating enough space for the pointer capdata, but I don't know how
to determine how much space I need.

Here is the code

// Test out the alsa library
//
#include <alsa/asoundlib.h>
#include <cstdio>
#include <unistd.h>

bool getMonoDevice(snd_pcm_t *pcm_handle, snd_pcm_stream_t stream,
unsigned int rate, int periods, snd_pcm_uframes_t periodsize);

int main()
    {
    snd_pcm_t *pcm_handle_read;
    snd_pcm_t *pcm_handle_write;
    snd_pcm_stream_t stream = SND_PCM_STREAM_CAPTURE;

    unsigned int rate = 44100;
    int periods = 2;
    snd_pcm_uframes_t periodsize = 8192;

    if (!getMonoDevice(pcm_handle_write,
SND_PCM_STREAM_PLAYBACK,rate,periods,periodsize))
        {
        fprintf(stderr, "Error couldn't open speakers\n");
        return -1;
        }
    if (!getMonoDevice(pcm_handle_read,
SND_PCM_STREAM_CAPTURE,rate,periods,periodsize))
        {
        fprintf(stderr, "Error couldn't open microphone\n");
        return -1;
        }

    //read frames from device
    //and echo them out
    unsigned char *capdata;
    int pcmreturn;
    int num_frames;
    int error;

    capdata = (unsigned char *)malloc(periodsize);
    num_frames = periodsize * 2;
    while (true)
        {
        while ((pcmreturn = snd_pcm_readi(pcm_handle_read, capdata,
num_frames)) < 0)
            {
            usleep(10);
            error = snd_pcm_prepare(pcm_handle_read);
            if (error < 0)
                {
                fprintf(stderr, "Unrecoverable mic error
%s\n",snd_strerror(error));
                return error;
                }
            }
        while ((pcmreturn = snd_pcm_writei(pcm_handle_write, capdata,
num_frames)) < 0)
            {
            usleep(10);
            error = snd_pcm_prepare(pcm_handle_write);
            if (error < 0)
                {
                fprintf(stderr, "Unrecoverable speaker error
%s\n",snd_strerror(error));
                return error;
                }
            }
        }

    //stop pcm device and drop pending frames
    snd_pcm_drop(pcm_handle_read);
    snd_pcm_drain(pcm_handle_read);
    snd_pcm_drop(pcm_handle_write);
    snd_pcm_drain(pcm_handle_write);
    }


bool getMonoDevice(snd_pcm_t *pcm_handle, snd_pcm_stream_t stream,
unsigned int rate, int periods, snd_pcm_uframes_t periodsize)
    {
    snd_pcm_hw_params_t *hwparams;

    char *pcm_name;

    pcm_name = strdup("plughw:0,0");

    snd_pcm_hw_params_alloca(&hwparams);

    if (snd_pcm_open(&pcm_handle, pcm_name, stream, 0) < 0)
        {
        fprintf(stderr, "Error opening PCM device %s\n", pcm_name);
        return false;
        }

    if (snd_pcm_hw_params_any(pcm_handle, hwparams) < 0 )
        {
        fprintf(stderr, "Can not configure this PCM device.\n");
        return false;
        }

    unsigned int exact_rate;
    int dir;

    if (snd_pcm_hw_params_set_access(pcm_handle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED) < 0)
        {
        fprintf(stderr, "Error setting access.\n");
        return false;
        }

    if (snd_pcm_hw_params_set_format(pcm_handle, hwparams,
SND_PCM_FORMAT_S16_LE) < 0)
        {
        fprintf(stderr, "Error setting format.\n");
        return false;
        }

    exact_rate = rate;
    if (snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams,
&exact_rate, 0) < 0)
        {
        fprintf(stderr, "Error setting rate.\n");
        return false;
        }
    if (rate != exact_rate)
        {
        fprintf(stderr, "The rate %d is not supported by your
hardware.\n Using %d Hz instead.\n", rate, exact_rate);
        }

    //Configure mono sound
    if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 1) < 0)
        {
        fprintf(stderr, "Error setting channels.\n");
        return false;
        }

    if (snd_pcm_hw_params_set_periods(pcm_handle, hwparams, periods, 0) < 0)
        {
        fprintf(stderr, "Error setting periods.\n");
        return false;
        }

    if (snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams,
(periodsize * periods) >> 2) < 0 )
        {
        fprintf(stderr, "Error setting buffersize.\n");
        return false;
        }

    if (snd_pcm_hw_params(pcm_handle, hwparams) < 0)
        {
        fprintf(stderr, "Error setting HW params.\n");
        return false;
        }

    //device is finally configured
    return true;
    }
