From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Not able to restart audio after hibernation
Date: Sun, 8 Jan 2012 21:53:58 -0800
Message-ID: <20120109055357.GL29065@opensource.wolfsonmicro.com>
References: <4F06D156.1020208@st.com>
	<20120106183203.GA2893@opensource.wolfsonmicro.com>
	<20120109031645.GA21422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B414103957
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 06:54:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120109031645.GA21422@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shiraz Hashim <shiraz.hashim@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, "tiwai@suse.de" <tiwai@suse.de>, "spear--sw-devel@lists.codex.cro.st.com" <spear--sw-devel@lists.codex.cro.st.com>, Armando VISCONTI <armando.visconti@st.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 08:46:45AM +0530, Shiraz Hashim wrote:
> On Sat, Jan 07, 2012 at 02:32:05AM +0800, Mark Brown wrote:

> > This suggests that you have a bug in your suspend and resume
> > implementation, possibly outside of this driver.

> The driver works absolutely fine in case of suspend to ram where the
> power domains (which includes the I2S controller) is switched off.

That doesn't mean everything is OK, for example the clock tree or DMA
controller might not be preserving state properly.

> As the soc-core.c misses hibernation call backs of dev_pm_ops, we were
> wondering whether it has been tested before on some other platform.

Not to my knowledge, but I don't see any reason why anything more than
the trivial implementation should really be needed except for the
general pointlessness of resuming after hibernating.
