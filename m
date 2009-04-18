From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Sat, 18 Apr 2009 10:11:53 +0100
Message-ID: <20090418091153.GA28946@n2100.arm.linux.org.uk>
References: <20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
	<20090402123844.GD9522@n2100.arm.linux.org.uk>
	<20090402133124.GE9522@n2100.arm.linux.org.uk>
	<20090402141200.GH4527@sirena.org.uk>
	<20090402144017.GI9522@n2100.arm.linux.org.uk>
	<20090402145330.GA21646@sirena.org.uk>
	<20090402150922.GK9522@n2100.arm.linux.org.uk>
	<20090402152234.GA24804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 946491037F4
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Apr 2009 11:12:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402152234.GA24804@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 04:22:34PM +0100, Mark Brown wrote:
> On Thu, Apr 02, 2009 at 04:09:22PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 02, 2009 at 03:53:30PM +0100, Mark Brown wrote:
> 
> > > Compile tested only.
> 
> > I beg to disagree with that statement...
> 
> Sorry about that - spot the use of git commit --amend.
> 
> > Fixing these results in something which can be built, and along with
> > your other two for the soc-core resume and the ac97 device parent,
> > the complaints from the touchscreen driver no longer appear.
> 
> Excellent - I'll push the fixed patches to Takashi when he's back from
> vacation.  Thanks again for your work tracking this down.

I notice that the fixes were merged, minus one:

sound/soc/codecs/wm9705.c: At top level:
sound/soc/codecs/wm9705.c:445: warning: initialization from incompatible pointer type

so you might find this trivial patch useful.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 6e23a81..c2d1a7a 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -318,7 +318,7 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm9705_soc_suspend(struct platform_device *pdev)
+static int wm9705_soc_suspend(struct platform_device *pdev, pm_message_t msg)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
