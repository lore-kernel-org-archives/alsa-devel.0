From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: idt blue jack patch
Date: Tue, 24 Feb 2009 10:30:30 +0800
Message-ID: <20090224023030.GA7778@localhost>
References: <20090220010001.GA7520@localhost> <s5hbpsx10yg.wl%tiwai@suse.de>
	<20090221014214.GB6175@localhost>
	<s5hljrzu53u.wl%tiwai@suse.de> <s5h7i3h4joz.wl%tiwai@suse.de>
	<20090223095351.GA18093@localhost> <s5h3ae51mjl.wl%tiwai@suse.de>
	<20090223125820.GA7403@localhost>
	<s5hd4d9z4sk.wl%tiwai@suse.de> <s5hy6vx86zt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 61F7B24486
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 03:33:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy6vx86zt.wl%tiwai@suse.de>
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
Cc: Paulo Cavalcanti <promac@gmail.com>, Vedran =?utf-8?Q?Mileti=C4=87?= <rivanvx@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 23, 2009 at 06:15:18PM +0200, Takashi Iwai wrote:
> At Mon, 23 Feb 2009 14:00:43 +0100,
> I wrote:
> > > > > - if reconfig while playing audio, it will trigger a panic:
> > > > 
> > > > Ah, that's bad.  I know this can be a problem (and thus is marked as
> > > > EXPERIMENTAL :)
> > > > 
> > > > We need some mutex and/or flag to disable the reconfig during the
> > > > critical operation.
> > > 
> > > It won't be a trivial work. The reset/rebuild is a long and complex process.
> > > For the moment I'd suggest to simply fail reconfig if there are active streams,
> > 
> > Yep, that's what I thought of, too.
> > 
> > > so as to let this useful feature go upstream ASAP.
> > 
> > I'll merge the branch soon later.
> 
> FYI, now the branch is merged to master.
> The dynamic pincfg feature is available on alsa-driver snapshot, too.
> 
> Also, I added the check of opened streams before doing clear/reconfig
> work so that the kernel panic won't happen so easily.

That's great, thank you!

Regards,
Fengguang
