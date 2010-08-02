From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: How to handle HBR pass-through? (new PCM_FORMAT?)
Date: Sun, 1 Aug 2010 20:18:35 -0700
Message-ID: <AANLkTi=MCNmW5qUT0spwu31UO3qmSFShw1vgkSAvU4ro@mail.gmail.com>
References: <201008011423.33724.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8834D24440
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 05:18:38 +0200 (CEST)
Received: by iwn39 with SMTP id 39so4126815iwn.38
	for <alsa-devel@alsa-project.org>; Sun, 01 Aug 2010 20:18:37 -0700 (PDT)
In-Reply-To: <201008011423.33724.anssi.hannula@iki.fi>
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

> What this means is that if just the needed HBR bits are set in the audio
> driver, one can play back e.g. TrueHD by passing the IEC-61937 stream to ALSA
> as 192kHz 8-channel 16-bit PCM data; of course normal 8-channel PCM playback
> wouldn't work anymore then. So the driver would need to know if this is 8-
> channel PCM or 8-channel compressed audio.
>
> Which brings us to my question: How should the user be able to do this, i.e.
> inform the driver whether this is 8-channel PCM data or compressed audio data?
>
>
> One easy option would be to have a separate IEC61937_HBR format in ALSA which
> could be used for IEC-61937 streams represented as 8x 16-bit channels.
>
> If that would be considered too specific, we could add a more generic IEC61937
> format, which is the same as above except that "normal" ( = "2 channel")
> IEC-61937 streams could be used as well. However, as normal IEC-61937 streams
> can be used with S/PDIF as well, we'd AFAICS need to add such format bit to
> all S/PDIF drivers or have a no-op converter to the more widely supported 16-
> bit PCM format.

Could we require that the user sets the channel status bits (with the
AESx controls) in case this is compressed. The driver would then make
an informed decision to use HBR packets instead of regular PCM 8-ch
layout2?
At any rate, supporting such formats entails changes to higher levels
of the audio stack, for example gstreamer/alsasink would need
additional caps. Changes are not limited to the alsa driver I guess.
