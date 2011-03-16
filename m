From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA	framework
Date: Wed, 16 Mar 2011 08:21:48 +0100
Message-ID: <4D80650C.4000006@ladisch.de>
References: <4D7FB076.30300@codeaurora.org> <4D7FCEA3.4070003@audioscience.com> <4D7FF63B.40805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4D7FF63B.40805@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Eliot Blennerhassett <linux@audioscience.com>, linux-arm-msm@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Patrick Lai wrote:
> Why is AC3 passthrough acceptable

Because it pretends to be a normal 16-bit stereo stream at 48 kHz,
the only difference is that the IEC958 non-audio bit is set.

> but not other compressed audio format?

Other formats like DTS or WMA can be transported in the same way.

> Eliot Blennerhassett wrote:
> > ALSA might be extended to cope with compressed audio with fixed frame
> > size and bitrate, but dealing with any VBR encoding is likely to be even
> > more problematic.


Regards,
Clemens
