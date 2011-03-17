From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA	framework
Date: Thu, 17 Mar 2011 08:39:33 +0100
Message-ID: <4D81BAB5.5060204@ladisch.de>
References: <4D7FB076.30300@codeaurora.org> <4D7FCEA3.4070003@audioscience.com>	<4D7FF63B.40805@codeaurora.org> <4D8134C6.30104@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4D8134C6.30104@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Patrick Lai wrote:
> Where can I find user-space code snippet to see how ALSA is configured 
> for IEC958 playback?

Use the ALSA device name "iec958" (or its alias "spdif").
For another than the default sound card, use "iec958:x".

For compressed formats, you have to set the non-audio bit.
Thise device has four parameters AES0..3 for the four bytes
of S/PDIF metainformation.  The non-audio bit can be set by
adding the parameter "AES0=6"; the complete device name then
looks like "spdif:AES0=6" or "spdif:other=parameters,AES0=6"
or "spdif:{ other-parameters ... AES0=6 }".

The try_open_device function of mplayer tries to do this:
http://git.mplayerhq.hu/?p=mplayer;a=blob;hb=HEAD;f=libao2/ao_alsa.c


Regards,
Clemens
