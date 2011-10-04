From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [RFC 2/3] ASoC: davinci-pcm: add cpu-dai health
	callbacks
Date: Mon, 3 Oct 2011 22:05:45 -0400
Message-ID: <CAPcSpELVrSNCT4bZ9p+NL_ti7+sP=KVf006j8xP9eM9_yF0Kvw@mail.gmail.com>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
	<beb331a90431ab4dfefedc45f53e686df3bc3f61.1317417232.git.bengardiner@nanometrics.ca>
	<20111002185434.GH2857@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id BA04D2432E
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 04:05:46 +0200 (CEST)
Received: by mail-gy0-f179.google.com with SMTP id 4so11007gyg.10
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 19:05:45 -0700 (PDT)
In-Reply-To: <20111002185434.GH2857@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 2, 2011 at 2:54 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> This looks like something we should be doing at the subsystem level, the
> DaVinci is far from unique in having the ability to detect errors at the
> DAI level.

Agreed; I started out with the intent to call DAI health ops from
snd_pcm_update_hw_ptr0() but I couldn't find may way to a cpudai
instance from the given substream. Any tips on this or a plan of
attack would be apreciated.

> Why do you prefer a fatal error, and how do you distinguish a fatal
> error from a glitch?

Our use of ALSA is such that in the rare case of either a glitch or a
hardware error we would prefer to fail fatally rather than ignore.
This is because we would like to guarantee that playback occurred
correctly or not at all.

>From your other email I see now that the intended behaviour can be
accomplished entirely in the application. Returning _POS_XRUN should
be sufficient here in ASoC.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
