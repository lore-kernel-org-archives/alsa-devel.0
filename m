From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: |PATCH] ASoC: Convert wm8510 to a new-style i2c
	driver
Date: Tue, 2 Sep 2008 14:07:20 +0100
Message-ID: <20080902130720.GD25176@sirena.org.uk>
References: <20080901112331.594bb663@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9896A246B2
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 15:07:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080901112331.594bb663@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <gwossum@acm.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2008 at 11:23:31AM +0200, Jean Delvare wrote:
> Convert the wm8510 codec driver to the new (standard) device
> driver binding model.

Hrm.  This doesn't actually apply for me, even if I apply directly
against 2.6.27-rc5 - I get rejects in wm8510.c in the main conversion
hunk.  Any chance you could regenerated it against Takashi's tree?

> --- linux-2.6.27-rc5.orig/sound/soc/at32/playpaq_wm8510.c	2008-09-01 09:59:13.000000000 +0200
> +++ linux-2.6.27-rc5/sound/soc/at32/playpaq_wm8510.c	2008-09-01 09:59:21.000000000 +0200
