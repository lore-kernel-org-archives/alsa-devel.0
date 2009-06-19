From: Guilherme <grlongo.ireland@gmail.com>
Subject: segfault when setting swparams! help
Date: Fri, 19 Jun 2009 04:27:58 -0300
Message-ID: <4A3B3DFE.1090709@gmail.com>
References: <1245369035.6830.27.camel@localhost> <s5h1vpgg2d6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 03396103815
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 09:28:03 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so834192qwj.56
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 00:28:02 -0700 (PDT)
In-Reply-To: <s5h1vpgg2d6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mates...

I am getting a segfault when running my app:

This is the part of the code where I am getting the error:

            if ((err =3D set_swparams(handle, swparams)) < 0) {
                  printf("Setting of swparams failed: %s\n", =

snd_strerror(err));
                  exit(EXIT_FAILURE);
           }

That is the gdb output:  (*The full program code's been posted below the =

debug output)

Starting program: /home/guilherme/Experimentos/PCM
[Thread debugging using libthread_db enabled]
[New Thread 0xb7c896c0 (LWP 3391)]
[Switching to Thread 0xb7c896c0 (LWP 3391)]

Breakpoint 1, main (argc=3D1, argv=3D0xbfa27da4) at pcm.c:777
777                    };
(gdb) n
783                    int method =3D 0;
(gdb) n
791                    morehelp =3D 0;
(gdb) n
794                                if ((c =3D getopt_long(argc, argv, =

"hd:r:c:f:b:p:m:o:vne", long_option, NULL)) < 0)
(gdb) nn
Undefined command: "nn".  Try "help".
(gdb) n
857                  if(morehelp) {
(gdb) n
863                    err =3D snd_output_stdio_attach(&output, &stdout, 0);
(gdb) n
864                    if (err < 0) {
(gdb) n
869                    printf("Playback device is %s\n", device);
(gdb) n
Playback device is default
870                    printf("Stream parameters are %iHz, %s, %i =

channels\n", rate, snd_pcm_format_name(format), channels);
(gdb) n
Stream parameters are 48000Hz, S16_LE, 1 channels
871                    printf("sine wave rate is %i %.4fHz\n", freq);
(gdb) n
sine wave rate is 0 0.0000Hz
872                    printf("Using transfer method: %s\n", =

transfer_methods[method].name);
(gdb) n
Using transfer method: write
874                    if ((err =3D snd_pcm_open(&handle, device, =

SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
(gdb) n
879                    if ((err =3D set_hwparams(handle, hwparams, =

transfer_methods[method].access)) < 0) {
(gdb) n

Program received signal SIGSEGV, Segmentation fault.
0xb7d47e3f in memset () from /lib/libc.so.6
(gdb) Quit
(gdb) quit
The program is running.  Exit anyway? (y or n)





That  is the code:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sched.h>
#include <errno.h>
#include <getopt.h>
#include <alsa/asoundlib.h>
#include <sys/time.h>
#include <math.h>

static char *device =3D "default";                       //playback device =

aplay -l
static snd_pcm_format_t format =3D SND_PCM_FORMAT_S16;   //sample format =

unsigned 16 bit endian
static unsigned int rate =3D 48000;                      //stream rate
static unsigned int channels =3D 1;                       //contagem dos =

canais
static unsigned int buffer_time =3D 500;              //ring buffer length =

on us
static unsigned int period_time =3D 100;              //period time in us
static double freq =3D 440;                              // frequencia da =

sen=F3ide em Hz
static int verbose =3D 0;                                //verbose flag
static int resample =3D 1;                               //abilitar =

alsa-lib resampling
static int period_event =3D 0;                           // produz um =

event pool a cada periodo

static snd_pcm_sframes_t buffer_size;                  //quantidade de =

buffers frames
static snd_pcm_sframes_t period_size;                  //quantidade de =

periods frames
static snd_output_t *output =3D NULL;                    //ALSA usa esse =

ponteiro para lidar com output objects


static void generate_sine(const snd_pcm_channel_area_t *areas,
                                          snd_pcm_uframes_t offset,
                                          int count, double *_phase)
{
        static double max_phase =3D 2. * M_PI;
        double phase =3D *_phase;
        double step =3D max_phase*freq / (double)rate;
        double res;
        unsigned char *samples[channels], *tmp;
        int steps[channels];
        unsigned int chn, byte;
       =

        union {
                int i;
                unsigned char c[4];
        } ires;
        unsigned int maxval =3D (1 << (snd_pcm_format_width(format) - 1)) -=
 1;
        int bps =3D snd_pcm_format_width(format) / 8; //bits per sample
       =

        /*verificar e preparar o conte=FAdo das areas*/
        for (chn =3D 0; chn < channels; chn++) {
            if ((areas[chn].first % 8) !=3D 0) {
                    printf("areas[%i].first =3D=3D %i, abortando...\n", chn=
, =

areas[chn].first);
                    exit(EXIT_FAILURE);
            }
            //pega endere=E7o e offset da area
            samples[chn] =3D /*(signed short *)*/(((unsigned char =

*)areas[chn].addr) + (areas[chn].first / 8));
           =

         if ((areas[chn].step % 16) !=3D 0) {
                printf("areas[%i].step =3D=3D %i, aborting...\n", chn, =

areas[chn].step);
                exit(EXIT_FAILURE);
         }
           =

                steps[chn] =3D areas[chn].step / 8;
                samples[chn] +=3D offset * steps[chn];
        }
       =

        //completa os channels da area
        while(count-- > 0) {
            res =3D sin(phase) * maxval;
            ires.i =3D res;
            tmp =3D ires.c;
            for (chn =3D 0; chn < channels; chn++) {
                    for (byte =3D 0; byte < (unsigned int)bps; byte++) =

*(samples[chn] + byte) =3D tmp[byte];
                        samples[chn] +=3D steps[chn];
                    }
                    phase +=3D step;
                    if (phase >=3D max_phase)
                            phase -=3D max_phase;
                    }
                    *_phase =3D phase;
  =

}                               =



static int set_hwparams(snd_pcm_t *handle,
                                snd_pcm_hw_params_t *params,
                                snd_pcm_access_t access)
{
        unsigned int rrate;
        snd_pcm_uframes_t size;
        int err, dir;
       =

        /*escolha todos os parametros*/
        err =3D snd_pcm_hw_params_any(handle, params);
        if (err < 0) {
                printf("Broken configuration for playback: no =

configuration available: %s\n", snd_strerror(err));
                return err;
        }
       =

        /*set hardware resampling*/
        err =3D snd_pcm_hw_params_set_rate_resample(handle, params, resampl=
e);
        if (err < 0) {
                printf("Resampling setup failed for playback: %s\n", =

snd_strerror(err));
                return err;
        }
       =

      /* set the interleaved read/write format */
      err =3D snd_pcm_hw_params_set_access(handle, params, access);
      if (err < 0) {
            printf("Access type not available for playback: %s\n", =

snd_strerror(err));
            return err;
       }
      =

      /* set the sample format SND_PCM_FORMAT_S16 */
       err =3D snd_pcm_hw_params_set_format(handle, params, format);
       if (err < 0) {
             printf("Sample format not available for playback: %s\n", =

snd_strerror(err));
             return err;
      }
     =

        /* set the count of channels 1  */
       err =3D snd_pcm_hw_params_set_channels(handle, params, channels);
       if (err < 0) {
             printf("Channels count (%i) not available for playbacks: =

%s\n", channels, snd_strerror(err));
             return err;
      }
     =

      /* set the stream rate */
       rrate =3D rate;
       err =3D snd_pcm_hw_params_set_rate_near(handle, params, &rrate, 0);
       if (err < 0) {
             printf("Rate %iHz not available for playback: %s\n", rate, =

snd_strerror(err));
             return err;
      }
      if (rrate !=3D rate) {
             printf("Rate doesn't match (requested %iHz, get %iHz)\n", =

rate, err);
            return -EINVAL;
      }
      /* set the buffer time */
      err =3D snd_pcm_hw_params_set_buffer_time_near(handle, params, =

&buffer_time, &dir);
      if (err < 0) {
           printf("Unable to set buffer time %i for playback: %s\n", =

buffer_time, snd_strerror(err));
           return err;
      }
      err =3D snd_pcm_hw_params_get_buffer_size(params, &size);
      if (err < 0) {
           printf("Unable to get buffer size for playback: %s\n", =

snd_strerror(err));
           return err;
      }
      buffer_size =3D size;
      /* set the period time */
      err =3D snd_pcm_hw_params_set_period_time_near(handle, params, =

&period_time, &dir);
      if (err < 0) {
           printf("Unable to set period time %i for playback: %s\n", =

period_time, snd_strerror(err));
           return err;
      }
      err =3D snd_pcm_hw_params_get_period_size(params, &size, &dir);
      if (err < 0) {
           printf("Unable to get period size for playback: %s\n", =

snd_strerror(err));
           return err;
      }
      period_size =3D size;
      /* write the parameters to device */
      err =3D snd_pcm_hw_params(handle, params);
      if (err < 0) {
           printf("Unable to set hw params for playback: %s\n", =

snd_strerror(err));
           return err;
      }
      return 0;
}



static int set_swparams(snd_pcm_t *handle, snd_pcm_sw_params_t *swparams) {

            int err;
           =

            /*pegar os parametros atuais swparams*/
            err =3D snd_pcm_sw_params_current(handle, swparams);
            if (err < 0) {
                printf("Unable to determine current swparams for =

playback: %s\n", snd_strerror(err));
                return err;
            }
            /*Come=E7a a transfer=EAncia quando o buffer est=E1 quase cheio=
*/
            /*(buffer_size / avail_min) * avail_min */
            err =3D snd_pcm_sw_params_set_avail_min(handle, swparams, =

(buffer_size / period_size) * period_size);
            if (err < 0) {
                printf("Unable to set start threshold mode for playback: =

%s\n", snd_strerror(err));
                return err;
            }
            /* allow the transfer when at least period_size samples can =

be processed */
          /* or disable this mechanism when period event is enabled (aka =

interrupt like style processing) */
          err =3D snd_pcm_sw_params_set_avail_min(handle, swparams, =

period_event ? buffer_size : period_size);
          if (err < 0) {
                 printf("Unable to set avail min for playback: %s\n", =

snd_strerror(err));
                  return err;
         }
          /* enable period events when requested */
         if (period_event) {
                  err =3D snd_pcm_sw_params_set_period_event(handle, =

swparams, 1);
                  if (err < 0) {
                          printf("Unable to set period event: %s\n", =

snd_strerror(err));
                          return err;
                 }
          }
          /* write the parameters to the playback device */
          err =3D snd_pcm_sw_params(handle, swparams);
          if (err < 0) {
                  printf("Unable to set sw params for playback: %s\n", =

snd_strerror(err));
                  return err;
          }
          return 0;
 }

/* Tenta recuperar estados de underrun e suspend */

static int xrun_recovery(snd_pcm_t *handle, int err)
{
            if (verbose)
                    printf("stream recovery\n");
            if (err =3D=3D -EPIPE) {      //under-run*/
                    err =3D snd_pcm_prepare(handle);
                    if (err < 0)
                                printf("Can't recovery from underrun, =

prepare failed: %s\n", snd_strerror(err));
                    return 0;
            } else if (err =3D=3D -ESTRPIPE) {
                    while ((err =3D snd_pcm_resume(handle)) =3D=3D -EAGAIN)
                            sleep(1); /*espera pela release flag*/
                    if (err < 0) {
                            err =3D snd_pcm_prepare(handle);
                            if (err < 0)
                                    printf("Can't recovery from suspend, =

prepare failed: %s\n", snd_strerror(err));
                            }
                            return 0;
                    }
                    return err;
}

/* Metodo de transfer=EAncia *WRITE-ONLY* */
static int write_loop(snd_pcm_t *handle,
                             signed short *samples,
                             snd_pcm_channel_area_t *areas)
{
        double phase =3D 0;
        signed short *ptr;
        int err, cptr;
       =

        while(1) {
            generate_sine(areas, 0, period_size, &phase);
            ptr =3D samples;
            cptr =3D period_size;
            while (cptr > 0) {
                    err =3D snd_pcm_writei(handle, ptr, cptr);
                    if (err =3D=3D -EAGAIN)
                                 continue;
                    if (err < 0) {
                         if (xrun_recovery(handle, err) < 0) {
                                 printf("Write error: %s\n", =

snd_strerror(err));
                                 exit(EXIT_FAILURE);
                         }//if
                         ptr +=3D err * channels;
                         cptr -=3D err;
                   }//if
                    }//if

         }//while
}


 /*
 *   M=E9todo de transfer=EAncia - write and wait por espa=E7o no buffer
 */

static int wait_for_poll(snd_pcm_t *handle, struct pollfd *ufds, =

unsigned int count)
{
        unsigned short revents;

        while (1) {
                 poll(ufds, count, -1);
                 snd_pcm_poll_descriptors_revents(handle, ufds, count, =

&revents);
                 if (revents & POLLERR)
                        return -EIO;
                 if (revents & POLLOUT)
                        return 0;
        }
}


static int write_and_poll_loop(snd_pcm_t *handle,
                                 signed short *samples,
                                 snd_pcm_channel_area_t *areas)
  {
          struct pollfd *ufds;
          double phase =3D 0;
          signed short *ptr;
          int err, count, cptr, init;
 =

          count =3D snd_pcm_poll_descriptors_count (handle);
          if (count <=3D 0) {
                  printf("Invalid poll descriptors count\n");
                  return count;
          }
 =

          ufds =3D malloc(sizeof(struct pollfd) * count);
          if (ufds =3D=3D NULL) {
                  printf("No enough memory\n");
                  return -ENOMEM;
          }
          if ((err =3D snd_pcm_poll_descriptors(handle, ufds, count)) < 0) {
                  printf("Unable to obtain poll descriptors for =

playback: %s\n", snd_strerror(err));
                  return err;
          }
 =

          init =3D 1;
          while (1) {
                  if (!init) {
                          err =3D wait_for_poll(handle, ufds, count);
                          if (err < 0) {
                                 if (snd_pcm_state(handle) =3D=3D =

SND_PCM_STATE_XRUN ||
                                      snd_pcm_state(handle) =3D=3D =

SND_PCM_STATE_SUSPENDED) {
                                          err =3D snd_pcm_state(handle) =3D=
=3D =

SND_PCM_STATE_XRUN ? -EPIPE : -ESTRPIPE;
                                          if (xrun_recovery(handle, err) =

< 0) {
                                                  printf("Write error: =

%s\n", snd_strerror(err));
                                                  exit(EXIT_FAILURE);
                                          }
                                          init =3D 1;
                                  } else {
                                          printf("Wait for poll failed\n");
                                         return err;
                                  }
                          }
                  }
 =

                  generate_sine(areas, 0, period_size, &phase);
                  ptr =3D samples;
                 cptr =3D period_size;
                  while (cptr > 0) {
                          err =3D snd_pcm_writei(handle, ptr, cptr);
                          if (err < 0) {
                                  if (xrun_recovery(handle, err) < 0) {
                                          printf("Write error: %s\n", =

snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                                  init =3D 1;
                                 break;  /* skip one period */
                          }
                          if (snd_pcm_state(handle) =3D=3D =

SND_PCM_STATE_RUNNING)
                                  init =3D 0;
                          ptr +=3D err * channels;
                          cptr -=3D err;
                         if (cptr =3D=3D 0)
                                  break;
                           /* it is possible, that the initial buffer =

cannot store */
                          /* all data from the last period, so wait =

awhile */
                          err =3D wait_for_poll(handle, ufds, count);
                          if (err < 0) {
                                  if (snd_pcm_state(handle) =3D=3D =

SND_PCM_STATE_XRUN ||
                                     snd_pcm_state(handle) =3D=3D =

SND_PCM_STATE_SUSPENDED) {
                                          err =3D snd_pcm_state(handle) =3D=
=3D =

SND_PCM_STATE_XRUN ? -EPIPE : -ESTRPIPE;
                                          if (xrun_recovery(handle, err) =

< 0) {
                                                  printf("Write error: =

%s\n", snd_strerror(err));
                                                  exit(EXIT_FAILURE);
                                          }
                                          init =3D 1;
                                  } else {
                                          printf("Wait for poll failed\n");
                                         return err;
                                  }
                          }
                 }
          }
}



/*
*  Metodo de transferencia - Notifica=E7=E3o assincrona
*/


 struct async_private_data {
         signed short *samples;
         snd_pcm_channel_area_t *areas;
         double phase;
 };
 =


static void async_callback(snd_async_handler_t *ahandler)
{
         snd_pcm_t *handle =3D snd_async_handler_get_pcm(ahandler);
         struct async_private_data *data =3D =

snd_async_handler_get_callback_private(ahandler);
          signed short *samples =3D data->samples;
          snd_pcm_channel_area_t *areas =3D data->areas;
         snd_pcm_sframes_t avail;
          int err;
         =

         avail =3D snd_pcm_avail_update(handle);
          while (avail >=3D period_size) {
                 generate_sine(areas, 0, period_size, &data->phase);
                  err =3D snd_pcm_writei(handle, samples, period_size);
                  if (err < 0) {
                          printf("Write error: %s\n", snd_strerror(err));
                         exit(EXIT_FAILURE);
                 }
                  if (err !=3D period_size) {
                          printf("Write error: written %i expected =

%li\n", err, period_size);
                         exit(EXIT_FAILURE);
                 }
                  avail =3D snd_pcm_avail_update(handle);
          }
}


static int async_loop(snd_pcm_t *handle,
                        signed short *samples,
                       snd_pcm_channel_area_t *areas)
  {
          struct async_private_data data;
         snd_async_handler_t *ahandler;
          int err, count;
 =

         data.samples =3D samples;
          data.areas =3D areas;
         data.phase =3D 0;
          err =3D snd_async_add_pcm_handler(&ahandler, handle, =

async_callback, &data);
          if (err < 0) {
                  printf("Unable to register async handler\n");
                  exit(EXIT_FAILURE);
         }
         for (count =3D 0; count < 2; count++) {
                 generate_sine(areas, 0, period_size, &data.phase);
                  err =3D snd_pcm_writei(handle, samples, period_size);
                  if (err < 0) {
                         printf("Initial write error: %s\n", =

snd_strerror(err));
                         exit(EXIT_FAILURE);
                  }
                  if (err !=3D period_size) {
                          printf("Initial write error: written %i =

expected %li\n", err, period_size);
                         exit(EXIT_FAILURE);
                  }
          }
          if (snd_pcm_state(handle) =3D=3D SND_PCM_STATE_PREPARED) {
                  err =3D snd_pcm_start(handle);
                  if (err < 0) {
                         printf("Start error: %s\n", snd_strerror(err));
                          exit(EXIT_FAILURE);
                  }
          }
 =

         /* because all other work is done in the signal handler,
             suspend the process */
          while (1) {
                  sleep(1);
          }
}

 /*
 *   Transfer method - asynchronous notification + direct write
 */
 =

  static void async_direct_callback(snd_async_handler_t *ahandler)
  {
          snd_pcm_t *handle =3D snd_async_handler_get_pcm(ahandler);
          struct async_private_data *data =3D =

snd_async_handler_get_callback_private(ahandler);
          const snd_pcm_channel_area_t *my_areas;
          snd_pcm_uframes_t offset, frames, size;
          snd_pcm_sframes_t avail, commitres;
          snd_pcm_state_t state;
          int first =3D 0, err;
         =

          while (1) {
                  state =3D snd_pcm_state(handle);
                  if (state =3D=3D SND_PCM_STATE_XRUN) {
                          err =3D xrun_recovery(handle, -EPIPE);
                          if (err < 0) {
                                  printf("XRUN recovery failed: %s\n", =

snd_strerror(err));
                                  exit(EXIT_FAILURE);
                          }
                          first =3D 1;
                  } else if (state =3D=3D SND_PCM_STATE_SUSPENDED) {
                          err =3D xrun_recovery(handle, -ESTRPIPE);
                          if (err < 0) {
                                  printf("SUSPEND recovery failed: =

%s\n", snd_strerror(err));
                                  exit(EXIT_FAILURE);
                          }
                  }
                  avail =3D snd_pcm_avail_update(handle);
                  if (avail < 0) {
                          err =3D xrun_recovery(handle, avail);
                          if (err < 0) {
                                  printf("avail update failed: %s\n", =

snd_strerror(err));
                                   exit(EXIT_FAILURE);
                          }
                          first =3D 1;
                          continue;
                  }
                  if (avail < period_size) {
                          if (first) {
                                  first =3D 0;
                                  err =3D snd_pcm_start(handle);
                                  if (err < 0) {
                                          printf("Start error: %s\n", =

snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                 }
                         } else {
                                  break;
                          }
                          continue;
                  }
                 size =3D period_size;
                  while (size > 0) {
                          frames =3D size;
                          err =3D snd_pcm_mmap_begin(handle, &my_areas, =

&offset, &frames);
                          if (err < 0) {
                                  if ((err =3D xrun_recovery(handle, err)) =

< 0) {
                                          printf("MMAP begin avail =

error: %s\n", snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                                  first =3D 1;
                          }
                          generate_sine(my_areas, offset, frames, =

&data->phase);
                          commitres =3D snd_pcm_mmap_commit(handle, =

offset, frames);
                          if (commitres < 0 || =

(snd_pcm_uframes_t)commitres !=3D frames) {
                                  if ((err =3D xrun_recovery(handle, =

commitres >=3D 0 ? -EPIPE : commitres)) < 0) {
                                          printf("MMAP commit error: =

%s\n", snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                                  first =3D 1;
                          }
                          size -=3D frames;
                  }
         }
}


static int async_direct_loop(snd_pcm_t *handle,
                               signed short *samples ATTRIBUTE_UNUSED,
                               snd_pcm_channel_area_t *areas =

ATTRIBUTE_UNUSED)
  {
          struct async_private_data data;
          snd_async_handler_t *ahandler;
          const snd_pcm_channel_area_t *my_areas;
          snd_pcm_uframes_t offset, frames, size;
          snd_pcm_sframes_t commitres;
          int err, count;
 =

          data.samples =3D NULL;    /* we do not require the global sample =

area for direct write */
          data.areas =3D NULL;      /* we do not require the global areas =

for direct write */
          data.phase =3D 0;
         err =3D snd_async_add_pcm_handler(&ahandler, handle, =

async_direct_callback, &data);
          if (err < 0) {
                  printf("Unable to register async handler\n");
                  exit(EXIT_FAILURE);
          }
          for (count =3D 0; count < 2; count++) {
                  size =3D period_size;
                  while (size > 0) {
                          frames =3D size;
                          err =3D snd_pcm_mmap_begin(handle, &my_areas, =

&offset, &frames);
                          if (err < 0) {
                                  if ((err =3D xrun_recovery(handle, err)) =

< 0) {
                                          printf("MMAP begin avail =

error: %s\n", snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                 }
                         }
                          generate_sine(my_areas, offset, frames, =

&data.phase);
                          commitres =3D snd_pcm_mmap_commit(handle, =

offset, frames);
                          if (commitres < 0 || =

(snd_pcm_uframes_t)commitres !=3D frames) {
                                  if ((err =3D xrun_recovery(handle, =

commitres >=3D 0 ? -EPIPE : commitres)) < 0) {
                                          printf("MMAP commit error: =

%s\n", snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                          }
                          size -=3D frames;
                   }
          }
          err =3D snd_pcm_start(handle);
          if (err < 0) {
                  printf("Start error: %s\n", snd_strerror(err));
                  exit(EXIT_FAILURE);
          }
 =

         /* because all other work is done in the signal handler,
             suspend the process */
          while (1) {
                  sleep(1);
          }
}

 /*
 *   Transfer method - direct write only
 */
 =

 static int direct_loop(snd_pcm_t *handle,
                         signed short *samples ATTRIBUTE_UNUSED,
                         snd_pcm_channel_area_t *areas ATTRIBUTE_UNUSED)
  {
          double phase =3D 0;
         const snd_pcm_channel_area_t *my_areas;
          snd_pcm_uframes_t offset, frames, size;
         snd_pcm_sframes_t avail, commitres;
          snd_pcm_state_t state;
          int err, first =3D 1;
 =

          while (1) {
                  state =3D snd_pcm_state(handle);
                  if (state =3D=3D SND_PCM_STATE_XRUN) {
                          err =3D xrun_recovery(handle, -EPIPE);
                          if (err < 0) {
                                 printf("XRUN recovery failed: %s\n", =

snd_strerror(err));
                                  return err;
                          }
                          first =3D 1;
                 } else if (state =3D=3D SND_PCM_STATE_SUSPENDED) {
                         err =3D xrun_recovery(handle, -ESTRPIPE);
                          if (err < 0) {
                                  printf("SUSPEND recovery failed: =

%s\n", snd_strerror(err));
                                   return err;
                          }
                  }
                  avail =3D snd_pcm_avail_update(handle);
                  if (avail < 0) {
                          err =3D xrun_recovery(handle, avail);
                          if (err < 0) {
                                  printf("avail update failed: %s\n", =

snd_strerror(err));
                                  return err;
                          }
                          first =3D 1;
                          continue;
                  }
                  if (avail < period_size) {
                          if (first) {
                                  first =3D 0;
                                  err =3D snd_pcm_start(handle);
                                  if (err < 0) {
                                          printf("Start error: %s\n", =

snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                          } else {
                                  err =3D snd_pcm_wait(handle, -1);
                                  if (err < 0) {
                                          if ((err =3D =

xrun_recovery(handle, err)) < 0) {
                                                  printf("snd_pcm_wait =

error: %s\n", snd_strerror(err));
                                                  exit(EXIT_FAILURE);
                                          }
                                          first =3D 1;
                                  }
                          }
                          continue;
                  }
                  size =3D period_size;
                  while (size > 0) {
                           frames =3D size;
                          err =3D snd_pcm_mmap_begin(handle, &my_areas, =

&offset, &frames);
                          if (err < 0) {
                                 if ((err =3D xrun_recovery(handle, err)) =

< 0) {
                                          printf("MMAP begin avail =

error: %s\n", snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                                  first =3D 1;
                         }
                          generate_sine(my_areas, offset, frames, &phase);
                          commitres =3D snd_pcm_mmap_commit(handle, =

offset, frames);
                          if (commitres < 0 || =

(snd_pcm_uframes_t)commitres !=3D frames) {
                                 if ((err =3D xrun_recovery(handle, =

commitres >=3D 0 ? -EPIPE : commitres)) < 0) {
                                          printf("MMAP commit error: =

%s\n", snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                  }
                                 first =3D 1;
                          }
                          size -=3D frames;
                  }
          }
}

/*
 *   Transfer method - direct write only using mmap_write functions
 */
 =

 static int direct_write_loop(snd_pcm_t *handle,
                               signed short *samples,
                              snd_pcm_channel_area_t *areas)
 {
         double phase =3D 0;
          signed short *ptr;
          int err, cptr;
 =

          while (1) {
                  generate_sine(areas, 0, period_size, &phase);
                 ptr =3D samples;
                  cptr =3D period_size;
                  while (cptr > 0) {
                          err =3D snd_pcm_mmap_writei(handle, ptr, cptr);
                          if (err =3D=3D -EAGAIN)
                                  continue;
                          if (err < 0) {
                                  if (xrun_recovery(handle, err) < 0) {
                                          printf("Write error: %s\n", =

snd_strerror(err));
                                          exit(EXIT_FAILURE);
                                 }
                                 break;  /* skip one period */
                         }
                          ptr +=3D err * channels;
                          cptr -=3D err;
                  }
          }
}

struct transfer_method {
       const char *name;
       snd_pcm_access_t access;
       int (*transfer_loop)(snd_pcm_t *handle,
                            signed short *samples,
                            snd_pcm_channel_area_t *areas);
};

static struct transfer_method transfer_methods[] =3D {
          { "write", SND_PCM_ACCESS_RW_INTERLEAVED, write_loop },
          { "write_and_poll", SND_PCM_ACCESS_RW_INTERLEAVED, =

write_and_poll_loop },
          { "async", SND_PCM_ACCESS_RW_INTERLEAVED, async_loop },
          { "async_direct", SND_PCM_ACCESS_MMAP_INTERLEAVED, =

async_direct_loop },
          { "direct_interleaved", SND_PCM_ACCESS_MMAP_INTERLEAVED, =

direct_loop },
          { "direct_noninterleaved", SND_PCM_ACCESS_MMAP_NONINTERLEAVED, =

direct_loop },
          { "direct_write", SND_PCM_ACCESS_MMAP_INTERLEAVED, =

direct_write_loop },
          { NULL, SND_PCM_ACCESS_RW_INTERLEAVED, NULL }
};



static void help(void)
{
         int k;
          printf(
  "Usage: pcm [OPTION]... [FILE]...\n"
  "-h,--help      help\n"
  "-D,--device    playback device\n"
  "-r,--rate      stream rate in Hz\n"
  "-c,--channels  count of channels in stream\n"
  "-f,--frequency sine wave frequency in Hz\n"
  "-b,--buffer    ring buffer size in us\n"
  "-p,--period    period size in us\n"
  "-m,--method    transfer method\n"
  "-o,--format    sample format\n"
  "-v,--verbose   show the PCM setup parameters\n"
  "-n,--noresample  do not resample\n"
  "-e,--pevent    enable poll event after each period\n"
  "\n");
          printf("Recognized sample formats are:");
         for (k =3D 0; k < SND_PCM_FORMAT_LAST; ++k) {
                  const char *s =3D snd_pcm_format_name(k);
                  if (s)
                          printf(" %s", s);
          }
          printf("\n");
          printf("Recognized transfer methods are:");
          for (k =3D 0; transfer_methods[k].name; k++)
                  printf(" %s", transfer_methods[k].name);
          printf("\n");
}



int main (int argc, char *argv[])
{
            struct option long_option[] =3D
                {
                     {"help", 0, NULL, 'h'},
                     {"device", 1, NULL, 'd'},
                     {"rate", 1, NULL, 'r'},
                     {"channels", 1, NULL, 'c'},
                     {"frequency", 1, NULL, 'f'},
                     {"buffer", 1, NULL, 'b'},
                     {"period", 1, NULL, 'p'},
                     {"method", 1, NULL, 'm'},
                     {"format", 1, NULL, 'o'},
                     {"verbose", 1, NULL, 'v'},
                     {"noresample", 1, NULL, 'n'},
                     {"pevent", 1, NULL, 'e'},
                     {NULL, 0, NULL, 0},
                };
               =

                snd_pcm_t *handle;                            //ponteiro =

para pcm handle
                int err, morehelp;
                snd_pcm_hw_params_t *hwparams;                =

//parametros de hardware
                snd_pcm_sw_params_t *swparams;                =

//parametros de software
                int method =3D 0;
                signed short *samples;
                unsigned int chn;
                snd_pcm_channel_area_t *areas;

                //snd_pcm_hw_params_alloca(&hwparams);
                //snd_pcm_sw_params_alloca(&swparams);
               =

                morehelp =3D 0;
                while (1) {
                            int c;
                            if ((c =3D getopt_long(argc, argv, =

"hd:r:c:f:b:p:m:o:vne", long_option, NULL)) < 0)
                                    break;
                            switch(c) {
                            case 'h':
                                        morehelp++;
                                        break;
                            case 'd':
                                        device =3D strdup(optarg);
                                        break;
                            case 'r':
                                        rate =3D atoi(optarg);
                                        rate =3D rate < 4000 ? 4000 : rate;
                                        rate =3D rate > 196000 ? 19600 : ra=
te;
                                        break;
                         case 'c':
                              channels =3D atoi(optarg);
                              channels =3D channels < 1 ? 1 : channels;
                              channels =3D channels > 1024 ? 1024 : channel=
s;
                              break;
                     case 'f':
                              freq =3D atoi(optarg);
                              freq =3D freq < 50 ? 50 : freq;
                              freq =3D freq > 5000 ? 5000 : freq;
                              break;
                     case 'b':
                              buffer_time =3D atoi(optarg);
                              buffer_time =3D buffer_time < 1000 ? 1000 : =

buffer_time;
                              buffer_time =3D buffer_time > 1000000 ? =

1000000 : buffer_time;
                              break;
                     case 'p':
                              period_time =3D atoi(optarg);
                              period_time =3D period_time < 1000 ? 1000 : =

period_time;
                              period_time =3D period_time > 1000000 ? =

1000000 : period_time;
                              break;
                     case 'm':
                              for (method =3D 0; =

transfer_methods[method].name; method++)
                                              if =

(!strcasecmp(transfer_methods[method].name, optarg))
                                              break;
                              if (transfer_methods[method].name =3D=3D NULL)
                                      method =3D 0;
                              break;
                     case 'o':
                              for (format =3D 0; format < =

SND_PCM_FORMAT_LAST; format++) {
                                      const char *format_name =3D =

snd_pcm_format_name(format);
                                      if (format_name)
                                              if =

(!strcasecmp(format_name, optarg))
                                              break;
                              }
                              if (format =3D=3D SND_PCM_FORMAT_LAST)
                                     format =3D SND_PCM_FORMAT_S16;
                              break;
                     case 'v':
                              verbose =3D 1;
                              break;
                     case 'n':
                              resample =3D 0;
                              break;
                      case 'e':
                              period_event =3D 1;
                              break;
                     }//switch
              }//while
             =

              if(morehelp) {
                          help();
                          return 0;
              }

                //cria um novo output objeto
                err =3D snd_output_stdio_attach(&output, &stdout, 0);
                if (err < 0) {
                        printf("Output failed: %s\n", snd_strerror(err));
                        return 0;
                }
               =

                printf("Playback device is %s\n", device);
                printf("Stream parameters are %iHz, %s, %i channels\n", =

rate, snd_pcm_format_name(format), channels);
                printf("sine wave rate is %i %.4fHz\n", freq);
                printf("Using transfer method: %s\n", =

transfer_methods[method].name);
               =

                if ((err =3D snd_pcm_open(&handle, device, =

SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
                        printf("Playback open error: %s\n", =

snd_strerror(err));
                        return 0;
                }
               =

                if ((err =3D set_hwparams(handle, hwparams, =

transfer_methods[method].access)) < 0) {
                  printf("Setting of hwparams failed: %s\n", =

snd_strerror(err));
                  exit(EXIT_FAILURE);
            }
            if ((err =3D set_swparams(handle, swparams)) < 0) {
                  printf("Setting of swparams failed: %s\n", =

snd_strerror(err));
                  exit(EXIT_FAILURE);
           }
 =

            if (verbose > 0)
                  snd_pcm_dump(handle, output);
               =

            samples =3D malloc((period_size * channels * =

snd_pcm_format_physical_width(format)) / 8);
            if (samples =3D=3D NULL) {
                  printf("No enough memory\n");
                  exit(EXIT_FAILURE);
            }
         =

            areas =3D calloc(channels, sizeof(snd_pcm_channel_area_t));
            if (areas =3D=3D NULL) {
                  printf("No enough memory\n");
                  exit(EXIT_FAILURE);
            }
            for (chn =3D 0; chn < channels; chn++) {
                  areas[chn].addr =3D samples;
                  areas[chn].first =3D chn * =

snd_pcm_format_physical_width(format);
                  areas[chn].step =3D channels * =

snd_pcm_format_physical_width(format);
             }
 =

            err =3D transfer_methods[method].transfer_loop(handle, =

samples, areas);
            if (err < 0)
                  printf("Transfer failed: %s\n", snd_strerror(err));
 =

            free(areas);
            free(samples);
            snd_pcm_close(handle);
            return 0;
}



Any ideas of what might be happening?? I've been looking for a =

reasonable explanation but i don't find any related error o online.

Tks in advanced!

Tks!

-------------------

Guilherme Longo
Dept. Eng. da Computa=E7=E3o
Unaerp

Linux User - #484927

*Before Asking
http://www.istf.com.br/?page=3Dperguntas

!- I'd rather die on my feet than live on my knees -!



Takashi Iwai wrote:
> At Fri, 19 Jun 2009 02:50:35 +0300,
> Maxim Levitsky wrote:
>   =

>> Hi,
>>
>> Due to lack of time, I didn't update kernel on my desktop system.
>> Now I notice that analog loopback go removed. Why?
>>     =

>
> Because it harms than helps more often.  I've got tons of bug reports
> and been upset just because users blindly set "Analog Loopback" mixer
> switch and lost their sound output.  This is no mixer element that
> behaves intuitively -- it shuts out PCM output instead of adding the
> analog loopback like other hardwares.
>
> The feature is still available, though.  You just need to give the
> driver an instruction via sysfs.  Namely, write to sysfs files
> corresponding to the IDT codec like
> 	# echo "loopback yes" > /sys/class/sound/hwC0D0/hints
> 	# echo 1 > /sys/class/sound/hwC0D0/reconfig
> Then the driver will reconfigure with the loopback mixer element.
> 	=

> I have a patch series to add this with a "patch" firmware file to
> make it easier, which I'm going to send an RFC to this ML soon later.
> Take a look at topic/hda-patch branch on sound-unstable tree.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   =
