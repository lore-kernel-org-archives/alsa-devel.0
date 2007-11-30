From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Fri, 30 Nov 2007 10:52:26 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711301050540.10769@tm8103.perex-int.cz>
References: <474E1189.9030701@keyaccess.nl> <s5hsl2pf8lf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9258224336
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 10:52:27 +0100 (CET)
In-Reply-To: <s5hsl2pf8lf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Rene Herman <rene.herman@gmail.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Nov 2007, Takashi Iwai wrote:

> At Thu, 29 Nov 2007 02:10:33 +0100,
> Rene Herman wrote:
> > 
> > Hi Takashi.
> > 
> > This removes the pnp_resource_change use from the ALSA ISAPnP drivers. In
> > 2.4 these were useful in providing an easy path to setting the resources,
> > but in 2.6 they retain function as a layering violation only.
> > 
> > This makes for a nice cleanup (-550 lines) of ALSA but moreover, ALSA is the
> > only remaining user of pnp_init_resource_table(), pnp_resource_change() and
> > pnp_manual_config_dev() (and, in fact, of "struct pnp_resource_table") in
> > the tree outide of drivers/pnp itself meaning it makes for more cleanup
> > potential inside the PnP layer.
> > 
> > Thomas Renninger acked their removal from that side, you did from the ALSA
> > side (CC list just copied from that thread).
> > 
> > Against current alsa-kernel HG. Many more potential cleanups in there, but 
> > this _only_ removes the pnp_resource_change code. Compile tested against 
> > current alsa-kernel HG and compile- and use-tested against 2.6.23.x (few 
> > offsets).
> > 
> > Signed-off-by: Rene Herman <rene.herman@gmail.com>
> 
> A good work.  I'll merge this tomorrow to ALSA tree if no one raises
> objection now.

Do we have a nice way to manually assign ISA resources at system level? 
Note that not all combinations work for all ISA PnP soundcards and we had bug 
reports that automatic PnP system failed in some cases.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
