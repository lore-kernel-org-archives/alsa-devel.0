From: "Jesslyn Abdul Salam" <jesslyn.abdulsalam@gmail.com>
Subject: Re: AIC23 SOC Driver on OSK5912
Date: Wed, 8 Oct 2008 16:12:14 +0530
Message-ID: <e762f7a90810080342p1195e436n9e17e2a1f81235e4@mail.gmail.com>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
	<20081007115450.GD19835@sirena.org.uk>
	<dfeb90390810070502x42ec3d85heb87f21d5c3074ec@mail.gmail.com>
	<e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
	<e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
	<e762f7a90810070518r22dfa404s3f34f3ade79db7bf@mail.gmail.com>
	<48EB6820.3090809@mistralsolutions.com>
	<e762f7a90810070650q642aa05eu1f909e7898042ee6@mail.gmail.com>
	<dfeb90390810070809r481f1a55wba410516bf2d1e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id C63812451C
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 12:42:28 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3553510rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 08 Oct 2008 03:42:14 -0700 (PDT)
In-Reply-To: <dfeb90390810070809r481f1a55wba410516bf2d1e9e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Arun,

Thanks for the update!  Finally i was able to play a wav file without
much problems.
But i came across few difficulties. Most probably it is due to the way
i built the alsa-libs and alsa-utils.
Earlier when i tried to play a sample wav file this was the result.

[root@osk5912 /]# aplay openal-1.wav
ALSA lib dlmisc.c:118:(snd_dlsym_verify) unable to verify version for
symbol _snd_pcm_empty_open
ALSA lib pcm.c:2148:(snd_pcm_open_conf) symbol _snd_pcm_empty_open is
not defined inside [builtin]
aplay: main:583: audio open error: No such device or address
[root@osk5912 /]#


Then I figured out we need to set the device when playing.

[root@osk5912 /]# aplay -D hw:0,0 openal-1.wav
Playing WAVE 'openal-1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
(it plays)

I tried encoding a wav file from a mp3 file and played using aplay

[root@osk5912 /]# aplay -D hw:0,0 rock.wav
Playing WAVE 'rock.wav' : Signed 32 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:954: Sample format non available
[root@osk5912 /]#

This file is 32bit and the previous one is 16. I reencoded the wav
file using the gstreamer to change the depth to 16bit

[root@osk5912 /]# aplay -D hw:0,0 rock2.wav
Playing WAVE 'rock2.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
(it plays file even though reencoding was not proper)

Then i tried sample files found in alsa-lib.

[root@osk5912 /]# aplay -D hw:0,0 Side_Left.wav
Playing WAVE 'Side_Left.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
aplay: set_params:959: Channels count non available
[root@osk5912 /]#

So it cannot play MONO and 32 bit files ?? Any ideas how to fix this
are welcome !!!!

- Jesslyn


On Tue, Oct 7, 2008 at 8:39 PM, Arun KS <arunks@mistralsolutions.com> wrote:
>
> On Tue, Oct 7, 2008 at 7:20 PM, Jesslyn Abdul Salam
> <jesslyn.abdulsalam@gmail.com> wrote:
> > Not yet. Would please share what you have done to make it work ? Also when I
> > tried to strace aplay , it keeps looking for a
> > </share/alsa/cards/tlv320aic23.conf> file which is not there in the alsa-lib
> > package. Any idea what goes in that file ?
>
> CCing in l-o mailing list too.
>
> I dont know about that file. I didnt face that issue.
>
> This is what i did to make it working. I guess its some omap1 related issue.
> This makes the omap_mcbsp_request(0) at boot time, instead of runtime.
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 3a4cc4b..6369703 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -151,8 +151,8 @@ static int omap_mcbsp_dai_startup(struct
> snd_pcm_substream *substream)
>        struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
>        int err = 0;
>
> -       if (!cpu_dai->active)
> -               err = omap_mcbsp_request(mcbsp_data->bus_id);
> +//     if (!cpu_dai->active)
> +//             err = omap_mcbsp_request(mcbsp_data->bus_id);
>
>        return err;
>  }
> @@ -164,7 +164,7 @@ static void omap_mcbsp_dai_shutdown(struct
> snd_pcm_substream *substream)
>        struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
>
>        if (!cpu_dai->active) {
> -               omap_mcbsp_free(mcbsp_data->bus_id);
> +//             omap_mcbsp_free(mcbsp_data->bus_id);
>                mcbsp_data->configured = 0;
>        }
>  }
> diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
> index 9477d18..98f1566 100644
> --- a/sound/soc/omap/osk5912.c
> +++ b/sound/soc/omap/osk5912.c
> @@ -209,6 +209,7 @@ static int __init osk_soc_init(void)
>               (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK,
>               clk_get_usecount(tlv320aic23_mclk));
>
> +       omap_mcbsp_request(0);
>
>        return 0;
>  err1:
>
> >
> > Regards
> >
> > Jesslyn
> >
> > On Tue, Oct 7, 2008 at 7:16 PM, Arun KS <arunks@mistralsolutions.com> wrote:
> >
> >> Jesslyn Abdul Salam wrote:
> >>
> >>> I got it working. I2C_BOARD_INFO macro was wrongly intialized. Instead of
> >>> tlv320aic23 i had written tlvaic23. Thanks to Arun for pointing this error
> >>>
> >>>
> >> Can you hear audio playing?
> >> Because i had done some hack to make it working in 5912osk.
> >> I want to know you are not facing it or not.
> >>
> >> Arun
> >>
> >>  Jesslyn Abdul Salam
> >>>
> >>>
> >>> On Tue, Oct 7, 2008 at 5:36 PM, Jesslyn Abdul Salam <
> >>> jesslyn.abdulsalam@gmail.com> wrote:
> >>>
> >>>
> >>>
> >>>> ---------- Forwarded message ----------
> >>>> From: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
> >>>> Date: Tue, Oct 7, 2008 at 5:36 PM
> >>>> Subject: Re: [alsa-devel] AIC23 SOC Driver on OSK5912
> >>>> To: Arun KS <arunks@mistralsolutions.com>
> >>>>
> >>>>
> >>>> Yes, it is there. but it shows as "tlv320aic23b" instead of "tlv320aic"
> >>>> Will that be the reason ????
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> On Tue, Oct 7, 2008 at 5:32 PM, Arun KS <arunks@mistralsolutions.com
> >>>> >wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Tue, Oct 7, 2008 at 5:24 PM, Mark Brown <broonie@sirena.org.uk>
> >>>>> wrote:
> >>>>>
> >>>>>
> >>>>>> On Tue, Oct 07, 2008 at 05:18:55PM +0530, Jesslyn Abdul Salam wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for
> >>>>>>> the
> >>>>>>>
> >>>>>>>
> >>>>>> past
> >>>>>
> >>>>>
> >>>>>> few days. I got the driver patch from the linux-omap/alsa-devel mailing
> >>>>>>> lists. The driver got compiled along just fine. But when the kernel
> >>>>>>>
> >>>>>>>
> >>>>>> boots,
> >>>>>
> >>>>>
> >>>>>> no sound cards have been listed.
> >>>>>>>
> >>>>>>>
> >>>>>> CCing in Arun KS <arunks@mistralsolutions.com> who contributed that
> >>>>>> support.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> Advanced Linux Sound Architecture Driver Version 1.0.17.
> >>>>>>>          ASoC version
> >>>>>>> 0.13.2
> >>>>>>> AIC23 Audio Codec
> >>>>>>> 0.1
> >>>>>>> MCLK = 12000000 [12000000], usecount =
> >>>>>>> 0
> >>>>>>> ALSA device
> >>>>>>> list:
> >>>>>>>    No soundcards
> >>>>>>> found.
> >>>>>>>          Any one have tested this before ?
> >>>>>>>
> >>>>>>>
> >>>>>> Can you check i2c?
> >>>>>
> >>>>> # cat /sys/bus/i2c/devices/1-001b/name
> >>>>> tlv320aic23
> >>>>>
> >>>>>
> >>>>>
> >>>>>> _______________________________________________
> >>>>>> Alsa-devel mailing list
> >>>>>> Alsa-devel@alsa-project.org
> >>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>>
> >>> _______________________________________________
> >>> Alsa-devel mailing list
> >>> Alsa-devel@alsa-project.org
> >>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >>>
> >>>
> >>>
> >>>
> >>
> >>
> >> Please do not print this email unless it is absolutely necessary. Spread
> >> environmental awareness.
> >>
> >>
> >> -------------------------------------------------------DISCLAIMER------------------------------------------------------
> >> The information transmitted herewith is confidential and proprietary
> >> information intended only for use by the individual or entity to which it is
> >> addressed. If the reader of this message is not the intended recipient, you
> >> are hereby notified that any review, retransmission, dissemination,
> >> distribution, copying or other use of, or taking of any action in reliance
> >> upon this information is strictly prohibited. If you have received this
> >> communication in error, please contact the sender and delete the material
> >> from your computer.
> >>
> >> --------------------------------------------------------------------------------------------------------------------------------
> >>
> >>
> >>
> >>
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
