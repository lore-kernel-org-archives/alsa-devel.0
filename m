From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: add STA32X codec driver
Date: Fri, 17 Jun 2011 10:45:31 +0100
Message-ID: <20110617094531.GC7851@opensource.wolfsonmicro.com>
References: <BANLkTinVAPv4gyAg3OOP=6oZ+bNEeAojDA@mail.gmail.com>
	<1308226043-18584-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64EA12443D
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 11:45:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308226043-18584-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 02:07:23PM +0200, Daniel Mack wrote:

Looks very good, a few small nits, if Liam's OK I guess we could fix
these incrementally:

> +#define DEBUG

This shouldn't be in the submission.

> +SOC_SINGLE_TLV("Master Volume", STA32X_MVOL, 0, 0xff, 1, mvol_tlv),
> +SOC_SINGLE("Master Playback Switch", STA32X_MMUTE, 0, 1, 1),
> +SOC_SINGLE("Ch1 Playback Switch", STA32X_MMUTE, 1, 1, 1),
> +SOC_SINGLE("Ch2 Playback Switch", STA32X_MMUTE, 2, 1, 1),
> +SOC_SINGLE("Ch3 Playback Switch", STA32X_MMUTE, 3, 1, 1),
> +SOC_SINGLE_TLV("Ch1 Volume", STA32X_C1VOL, 0, 0xff, 1, chvol_tlv),
> +SOC_SINGLE_TLV("Ch2 Volume", STA32X_C2VOL, 0, 0xff, 1, chvol_tlv),
> +SOC_SINGLE_TLV("Ch3 Volume", STA32X_C3VOL, 0, 0xff, 1, chvol_tlv),

The "Playback" should be consistently either present or not present in
both volume and mute controls so UIs can match them up easily.
