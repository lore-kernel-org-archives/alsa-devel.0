From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of
 pr_warning to pr_warn
Date: Fri, 17 Feb 2017 16:20:47 -0800
Message-ID: <1487377247.2198.9.camel@perches.com>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
 <20170217234854.spi62waguwd7kpno@sirena.org.uk>
 <20170217235751.GA4125@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0119.hostedemail.com
 [216.40.44.119])
 by alsa0.perex.cz (Postfix) with ESMTP id 725AD266649
 for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2017 01:20:55 +0100 (CET)
In-Reply-To: <20170217235751.GA4125@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-02-17 at 15:57 -0800, Nicolin Chen wrote:
> On Fri, Feb 17, 2017 at 11:48:54PM +0000, Mark Brown wrote:
> > On Fri, Feb 17, 2017 at 12:28:44PM -0800, Nicolin Chen wrote:
> > > On Thu, Feb 16, 2017 at 11:11:48PM -0800, Joe Perches wrote:
> > > > To enable eventual removal of pr_warning
> > > > =

> > > > This makes pr_warn use consistent for sound/soc
> > > > =

> > > > Prior to this patch, there were 5 uses of pr_warning and
> > > > 10 uses of pr_warn in sound/soc
> > > > =

> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > =

> > > For imx-audmux.c,
> > =

> > I don't have this patch, perhaps it got caught in a spam filter or
> > perhaps it got deleted because as ever you're not using subject lines
> > reflecting the style for the subsystem.
> =

> My bad that I didn't pay attention to the subject.
> =

> Joe, please fix it in v2. Thanks.
> =

> ASoC: Convert remaining uses of pr_warning to pr_warn

This is a treewide scripted patch which is
basically just a sed.

If or when you apply it, you should
fix it up to suit.

$ git log -1000 --pretty=3Doneline --no-merges sound/soc |=A0\
  cut -f2- -d" " | cut -f1 -d":" |sort | uniq
ALSA
AsoC
ASoc
ASoC
ASOC
ASoC fix up SND_SOC_WM8985 dependency
drm/i915/dp
kthread
lib/vsprintf.c
scripts/spelling.txt
sgtl5000
SoC
sound/soc
treewide
