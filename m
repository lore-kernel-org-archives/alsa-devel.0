From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: latency.c and delay related questions
Date: Tue, 20 Jun 2006 12:15:26 -0400
Message-ID: <1150820127.2754.116.camel@mindpipe>
References: <b6251a620606200310q7b532513s1aa6542368568460@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6251a620606200310q7b532513s1aa6542368568460@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Christophe Osuna <christophe.osuna@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-20 at 12:10 +0200, Christophe Osuna wrote:
> Hi,
> 
> I am trying to get small delays with my application and I have been
> playing with "latency" from alsa-lib/test.
> 

Can you please not post HTML to this list?

Lee

> The current delay with "latency" is equal to a minimum (that depends
> on the sound card) plus *two* times the period time.  If I disable
> manual change of sound card state as described in the patch below the
> delay becomes equal to a minimum *higher than the previous* plus *one*
> time the period time.
> 
> The delay has been measured with an external box plugged on the sound
> card.
> 
> I would like to mix both settings to get a delay of the lowest minimum
> plus one time the period time. But for this I need to understand what
> is happening, and more precisely:
> 
> * why is snd_pcm_link() mandatory? (no sound otherwise)
> * why two buffers of silence and not just one?
> * why is there no snd_pcm_start() for the playback device?
> * why is the minimum delay lower with manual handling of the sound 
> card state?
> 
> Help is welcome :-)
> 
> Thanxs in advance.
> 
> 
> 
> --- latency.c.orig      2006-06-20 10:21:57.000000000 +0200
> +++ latency.c   2006-06-20 11:06:10.000000000 +0200
> @@ -148,11 +148,11 @@
>                 printf("Unable to determine current swparams for %s: %
> s\n", id, snd_strerror(err
> ));
>                 return err;
>         }
> -       err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
> 0x7fffffff);
> -       if (err < 0) {
> -               printf("Unable to set start threshold mode for %s: %s
> \n", id, snd_strerror(err))
> ;
> -               return err;
> -       }
> +/*     err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
> 0x7fffffff); */
> +/*     if (err < 0) { */
> +/*             printf("Unable to set start threshold mode for %s: %s
> \n", id, snd_strerror(err))
> ; */
> +/*             return err; */
> +/*     } */
>         tick_time_ok = 0;
>         if (tick_time > 0) {
>                 unsigned int time, ttime;
> @@ -273,10 +273,10 @@
>                 exit(0);
>         }
> 
> -       if ((err = snd_pcm_prepare(phandle)) < 0) {
> -               printf("Prepare error: %s\n", snd_strerror(err));
> -               exit(0);
> -       }
> +/*     if ((err = snd_pcm_prepare(phandle)) < 0) { */
> +/*             printf("Prepare error: %s\n", snd_strerror(err)); */
> +/*             exit(0); */
> +/*     } */
> 
>         snd_pcm_dump(phandle, output);
>         snd_pcm_dump(chandle, output);
> @@ -646,27 +646,27 @@
>                 showlatency(latency);
>                 if (tick_time_ok)
>                         printf("Using tick time %ius\n",
> tick_time_ok);
> -               if ((err = snd_pcm_link(chandle, phandle)) < 0) {
> -                       printf("Streams link error: %s\n",
> snd_strerror(err));
> -                       exit(0);
> -               }
> -               if (snd_pcm_format_set_silence(format, buffer,
> latency*channels) < 0) {
> -                       fprintf(stderr, "silence error\n");
> -                       break;
> -               }
> -               if (writebuf(phandle, buffer, latency, &frames_out) <
> 0) {
> -                       fprintf(stderr, "write error\n");
> -                       break;
> -               }
> -               if (writebuf(phandle, buffer, latency, &frames_out) <
> 0) {
> -                       fprintf(stderr, "write error\n");
> -                       break;
> -               }
> -
> -               if ((err = snd_pcm_start(chandle)) < 0) {
> -                       printf("Go error: %s\n", snd_strerror(err));
> -                       exit(0);
> -               }
> +/*             if ((err = snd_pcm_link(chandle, phandle)) < 0) { */
> +/*                     printf("Streams link error: %s\n",
> snd_strerror(err)); */
> +/*                     exit(0); */
> +/*             } */
> +/*             if (snd_pcm_format_set_silence(format, buffer,
> latency*channels) < 0) { */
> +/*                     fprintf(stderr, "silence error\n"); */
> +/*                     break; */
> +/*             } */
> +/*             if (writebuf(phandle, buffer, latency, &frames_out) <
> 0) { */
> +/*                     fprintf(stderr, "write error\n"); */
> +/*                     break; */
> +/*             } */
> +/*             if (writebuf(phandle, buffer, latency, &frames_out) <
> 0) { */
> +/*                     fprintf(stderr, "write error\n"); */
> +/*                     break; */
> +/*             } */
> +
> +/*             if ((err = snd_pcm_start(chandle)) < 0) { */
> +/*                     printf("Go error: %s\n", snd_strerror(err));
> */
> +/*                     exit(0); */
> +/*             } */
>                 gettimestamp(phandle, &p_tstamp);
>                 gettimestamp(chandle, &c_tstamp);
>  #if 0
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
