From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi-ak4642: Remove
 ak4642_add_i2c_device
Date: Wed, 30 Dec 2009 12:39:24 +0000
Message-ID: <20091230123924.GA32304@opensource.wolfsonmicro.com>
References: <ur5qychhv.wl%morimoto.kuninori@renesas.com>
	<20091214114119.GE21066@rakim.wolfsonmicro.main>
	<uljh59k1j.wl%morimoto.kuninori@renesas.com>
	<6D292CE0-15AA-4990-9042-0381EDC07570@opensource.wolfsonmicro.com>
	<u637wx5nk.wl%morimoto.kuninori@renesas.com>
	<20091224114017.GA11850@opensource.wolfsonmicro.com>
	<20091225004502.GA32097@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0AF3243DC
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 13:39:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091225004502.GA32097@linux-sh.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 25, 2009 at 09:45:02AM +0900, Paul Mundt wrote:

> I missed the rest of this discussion, but if your conerns are about
> bisection, it's not an issue in this case. Board patches that add i2c or
> platform device data with no unmet dependencies I usually merge early.
> The main rationale for this is that the driver often shows up quite a bit
> later, and the board code will likely have had more paches piled up on
> top of it and merge conflicts ensue.

What I was hoping for was a single patch which removed the existing code
within ASoC and added the matching arch code so that there wouldn't be
any versions which either had duplicate adds or missing adds.  There's
no build time dependency, only a runtime one.
