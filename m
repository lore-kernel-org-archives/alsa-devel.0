From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Query about Playback device name
Date: Wed, 9 Mar 2011 17:16:58 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB568D@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5681@EXGMBX01.sasken.com>,
	<4D776867.9040905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 6421F103819
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:51:00 +0100 (CET)
In-Reply-To: <4D776867.9040905@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Clemens,


#################################################################################################################################

I get following error on console if i use  plug:mcasp3  instead  plughw:0,0
ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM mcasp3

/********************************************************/
     //alsaParams->playback_device = strdup("plughw:0,0");    /*commented*/
     alsaParams->playback_device = strdup("plug:mcasp3");
     snd_pcm_hw_params_alloca(&alsaParams->hwparams_playback);
     /*Open PCM Playback device*/
     if (snd_pcm_open(&alsaParams->playback_handle,   alsaParams->playback_device,  alsaParams->stream,    alsaParams->device_mode) < 0)
     {
        printf("Error opening PCM device %s\n", alsaParams->playback_device);
        return NULL;
     }

/********************************************************/

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: EVM [TI81XX EVM], device 0: McASP3 bdrsecodec-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: EVM [TI81XX EVM], device 1: McASP4 bdrsecodec-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

#################################################################################################################################

Regards
Irfan


________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Wednesday, March 09, 2011 5:15 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Query about Playback device name

Irfan Shaikh wrote:
> aplay uses following device
> "aplay -Dplug:mcasp3 411.2Kbps-44.1Khz-16bits-2CH-PCM.wav"
>
> I want to use same device i.e "plug:mcasp3" in my plaback application
>
> Can i use following section of code to use "plug:mcasp3" as playback device?
>
>     alsaParams->playback_device = strdup("plug:mcasp3");
>     if (snd_pcm_open(&alsaParams->playback_handle,
>                      alsaParams->playback_device,

Yes.

> SASKEN BUSINESS DISCLAIMER:

*** DISCLAIMER ***
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.


Regards,
Clemens
