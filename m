From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about
	snd_mixer_selem_get_playback_dB_range()
Date: Tue, 22 Mar 2011 08:11:09 +0100
Message-ID: <4D884B8D.1000103@ladisch.de>
References: <1300711933.24854.263.camel@IT-W2076>	<AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>	<1300715722.24854.290.camel@IT-W2076>
	<4D876303.3090100@ladisch.de> <1300718695.24854.310.camel@IT-W2076>
	<4D88497A.4090702@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A878E103826
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 08:09:41 +0100 (CET)
In-Reply-To: <4D88497A.4090702@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Tanu Kaskinen <tanu.kaskinen@digia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Peter Ujfalusi wrote:
> Looking at the patch itself, it does going to return
> min=SND_CTL_TLV_DB_GAIN_MUTE from snd_tlv_get_dB_range function.
> 
> However I have my doubts, if this is the correct way...
> 
> Take these two gain controls for example:
> RAW value   GAIN1  GAIN2
>    0        mute   mute
>    1        -2dB   0dB
>    2         0dB   1dB
>    3         2dB   2dB
> 
> If user space asks for the dB_range:
>         min    max
> GAIN1   mute   2dB
> GAIN2   mute   2dB
> 
> They are going to return with the same range, however if you ask for
> -2dB on both:
> GAIN1 will be -2dB
> GAIN2 will be muted

Or not, depending on which direction you instruct it to round.

> So we are kind of hiding the dB range for the control.

This is unavoidable if the only information returned is min/max.
To get the entire curve and resolution, you'd have to get the dB value
for each raw volume value.


Regards,
Clemens
