From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Allow more routing features for tlv320aic3x
Date: Wed, 26 Nov 2008 15:04:05 +0000
Message-ID: <20081126150404.GE6234@sirena.org.uk>
References: <20081126144854.GA20061@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 802CB2461B
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 16:04:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081126144854.GA20061@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 26, 2008 at 03:48:54PM +0100, Daniel Mack wrote:

> -	SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> +	SOC_DOUBLE_R("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> +		     PGAR_2_HPLOUT_VOL, 0, 0x7f, 1),
> +	SOC_DOUBLE_R("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
>  		     PGAR_2_HPROUT_VOL, 0, 0x7f, 1),

This should be two SOC_DOUBLEs (the end result is the same but that's
due to the implementation rather than anything else).  Other than that
the patch looks fine, though a more verbose patch description describing
briefly the routes that are being added (looks like mostly left<->right
cross connects?) would be nice.
