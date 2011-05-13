From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Fix wrong data type access in a few
	codec drivers
Date: Fri, 13 May 2011 08:54:34 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AA584@HQMAIL01.nvidia.com>
References: <1305296663-8284-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FF7B243AE
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 17:54:38 +0200 (CEST)
In-Reply-To: <1305296663-8284-1-git-send-email-jhnikula@gmail.com>
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
To: Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Jarkko Nikula wrote at Friday, May 13, 2011 8:24 AM:
> Commit fafd217 ("ASoC: Store a list of widgets in a DAPM mux/mixer
> kcontrol")
> changed the control private data type that is passed to snd_soc_cnew when
> creating dapm mixer and mux controls. Commit did not update a few codec
> drivers that are using their own put callbacks and thus are accessing a
> wrong data type.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Stephen Warren <swarren@nvidia.com>

Crap, sorry about that.

I think this needs to be fixed in a few more places:
wm8994_put_hp_enum
wm8994_put_class_w
wm8995_put_class_w

based on: cd sound/soc && grep -HrnI snd_kcontrol_chip .
... and finding all those that look up widgets not a codec.

Otherwise, on Tegra+WM8903, I repro'd the bug, and tested the fix, so:

Tested-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
