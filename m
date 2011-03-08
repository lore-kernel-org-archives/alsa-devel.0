From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: sgtl5000: use after free in
 ldo_regulator_register()
Date: Tue, 8 Mar 2011 18:57:26 +0000
Message-ID: <20110308185726.GD21538@opensource.wolfsonmicro.com>
References: <20110308113924.GC3416@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57700246AE
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 19:57:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110308113924.GC3416@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <b32542@freescale.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 08, 2011 at 02:39:24PM +0300, Dan Carpenter wrote:
> The "ldo" variable was dereferenced after free on the error path.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Applied, thanks.
