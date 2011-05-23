From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA and MediaController
Date: Mon, 23 May 2011 13:39:08 +0800
Message-ID: <BANLkTinyHbZWHUwEK0D4w1xrmKyLXRH-2w@mail.gmail.com>
References: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
	<BANLkTikTO64=LWWvwSPM=3uAW_CHNbMDNQ@mail.gmail.com>
	<20110521105732.GA10004@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 37B071037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 07:39:09 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4155957fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 22 May 2011 22:39:09 -0700 (PDT)
In-Reply-To: <20110521105732.GA10004@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> How Media controller or PA handle hda jack retasking of those 3 jacks
>> motherboard (channel mode or smart 5.1 switch) ?
>
>> For those mini ITX motherboard without front audio panel, there will
>> be no capture source if the HDA codec does not support stereo mix
>> after the driver retask those input jacks for 5.1 outputs
>
> This just sounds like a fairly basic reconfiguration of the CODEC, it's
> no different to any other rerouting.
>
>> Does this mean that those 3 jacks , 5 jacks and 6 jacks desktop need
>> to add the rear panel jack to use snd_jack_report ?
>
> It seems like a good idea to report any jacks we can do detection on....
>

But snd_jack API seem does not has any definition for "Line In" - Blue jacks ?

The jack retasking is performed by snd_hda_sequence_write_cache(codec,
chmode[mode].sequence) in snd_hda_ch_mode_put() for some HDA codecs
