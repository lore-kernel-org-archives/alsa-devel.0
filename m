From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Allow more routing features for tlv320aic3x
Date: Wed, 26 Nov 2008 16:28:11 +0000
Message-ID: <20081126162810.GF6234@sirena.org.uk>
References: <20081126144854.GA20061@buzzloop.caiaq.de>
	<20081126150404.GE6234@sirena.org.uk>
	<20081126155645.GA20913@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 93AD724729
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 17:28:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081126155645.GA20913@buzzloop.caiaq.de>
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

On Wed, Nov 26, 2008 at 04:56:45PM +0100, Daniel Mack wrote:

> -	SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> +	SOC_DOUBLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> +		     PGAR_2_HPLOUT_VOL, 0, 0x7f, 1),

Meh, sorry - I meant SOC_SINGLE here.  My mistake.
