From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Wed, 07 Dec 2011 09:47:29 +0200
Message-ID: <4EDF1A11.6080108@ti.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4EDC7A43.5040409@ti.com>
	<20111205113939.GF11150@opensource.wolfsonmicro.com>
	<4EDCC7E3.6060702@ti.com>
	<20111205134610.GO11150@opensource.wolfsonmicro.com>
	<4EDCDACC.1040409@ti.com>
	<20111205150747.GS11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id B1E4B24667
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 08:47:24 +0100 (CET)
Received: by lagw12 with SMTP id w12so2400lag.2
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 23:47:20 -0800 (PST)
In-Reply-To: <20111205150747.GS11150@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On 12/05/2011 05:07 PM, Mark Brown wrote:
>> The ordering of the pm_runtime_get/put will be different.
>> We will have the pm_runtime_put after all other parts of the audio
>> system has been closed, turned off.
> =

> Hrm, yes.  But that's much wider than just the issue with moving inside
> the pcm_lock - for example, the shutdown calls already come before the
> DAPM teardowns.

Sure, ideally I would pair the pm_runtime calls with the corresponding
startup/shutdown callback.

> So it sounds like things are OK with the proposed patch then, though
> there's still some larger issues to work through?

Yes, correct. I need to have pm_runtime support for the external
functional clock for the McPDM (coming as bit clock from twl6040 codec).

-- =

P=E9ter
