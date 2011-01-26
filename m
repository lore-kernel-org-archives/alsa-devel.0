From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] ASoC: tegra: Harmony: Support
	the	internal speaker
Date: Wed, 26 Jan 2011 11:00:34 +0000
Message-ID: <20110126110033.GA10759@sirena.org.uk>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295470205-26501-5-git-send-email-swarren@nvidia.com>
	<20110125202953.GB4605@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310955FA7@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 784F12452A
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:00:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310955FA7@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 07:46:57PM -0800, Stephen Warren wrote:

> With the existing soc-audio structure, one has to:

> 	platform_set_drvdata(harmony_snd_device, &snd_soc_harmony);

> I assume there's no need for this when registering via snd_soc_register_card;
> In other words, I'm free to use dev_set_drvdata on the platform_device/device
> so I can get rid of all the globals in harmony.y while I'm at it?

> I do see some internal use of set_drvdata/get_drvdata in soc-core.c. It
> looks like that's restricted to when the soc-audio platform_device is used,
> but I don't know if that's just co-incidence, or if it's a guarantee of the
> API. Can you confirm this?

Oh, bah.  The code is currently broken - suspend and resume are still
using the platform device.  I'll post a patch later today which removes
this requirement and adds callbacks for you to use.
