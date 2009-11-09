From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] ASoC: sh: fsi: Add runtime PM support
Date: Tue, 10 Nov 2009 08:39:50 +0900
Message-ID: <20091109233950.GB1059@linux-sh.org>
References: <uiqdkjvj2.wl%morimoto.kuninori@renesas.com>
	<uk4y0jvjc.wl%morimoto.kuninori@renesas.com>
	<20091109231408.GA1059@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by alsa0.perex.cz (Postfix) with ESMTP id 541462454A
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 00:40:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091109231408.GA1059@linux-sh.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 10, 2009 at 08:14:08AM +0900, Paul Mundt wrote:
> On Mon, Nov 09, 2009 at 11:12:39AM +0900, Kuninori Morimoto wrote:
> > This patch add support runtime PM.
> > Driver callbacks for Runtime PM are empty because
> > the device registers are always re-initialized after
> > pm_runtime_get_sync(). The Runtime PM functions replaces the
> > clock framework module stop bit handling in this driver.
> > 
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> On Mon, Nov 09, 2009 at 11:12:49AM +0900, Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> > ---
> >  arch/sh/boards/mach-se/7724/setup.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> These look fine, I'll queue them up.

Upon a closer look, it seems this is built on top of earlier changes in
the ASoC tree, so they should probably go through there so we don't end
up with the merge conflict later.

The board setup bits are harmless and shouldn't conflict with anything in
my tree, so there's no problem with taken both of these through the ASoC
tree.

Acked-by: Paul Mundt <lethal@linux-sh.org>
