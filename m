From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: HDAudio period/buffer sizes
Date: Mon, 15 Aug 2011 10:40:35 -0500
Message-ID: <47232.4988841594$1313422852@news.gmane.org>
References: <CABGFaBtLnbeHHYc4=oO=skmpiAZ3dpqWbavN8JYM-NLuVGovUg@mail.gmail.com>	<s5hk4b5384x.wl%tiwai@suse.de>
	<s5haac08f13.wl%tiwai@suse.de>	<CAN8ccib_61bF=KGN47DTop-Ow0st2rwi9KJ2iXw1DpUnP150CA@mail.gmail.com>
	<s5h39h4xpon.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E89A24690
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 17:40:37 +0200 (CEST)
In-Reply-To: <s5h39h4xpon.wl%tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>, 'Raymond Yau' <superquad.vortex2@gmail.com>
Cc: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > Does it mean that the period_bytes_min =128 can also be removed to
> > achieve lowest latency ?

Not sure who would want a latency lower than 0.66ms @ 48kHz? Looks to me like opening a can of worms.
-Pierre
