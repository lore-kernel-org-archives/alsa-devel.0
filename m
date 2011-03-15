From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA framework
Date: Tue, 15 Mar 2011 15:52:47 -0500
Message-ID: <AANLkTinsQf=RrzF6zEqFJrO+Q_gjF323kXGACU=OXd6j@mail.gmail.com>
References: <4D7FB076.30300@codeaurora.org>
	<4D7FCEA3.4070003@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4D7FCEA3.4070003@audioscience.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Patrick Lai <plai@codeaurora.org>, linux-arm-msm@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Given that audioscience makes cards that support mp3 encode/decode as
> well as pcm, I'd like it if alsa *did* support compressed audio...

You can use the IEC format for MPEG and use an ALSA driver if you
wanted and can afford the bandwidth waste and payload overhead.
We've been also playing with the notion of a new API, similar to ALSA
(ring buffer, periods, etc), but where references to samples/time
would be removed (all byte based). If there's enough interest in the
community maybe we can share this.
-Pierre
