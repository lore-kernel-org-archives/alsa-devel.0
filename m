From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: sysfs: WARNING:
	at	fs/sysfs/dir.c:424	sysfs_add_one() - with	ALSA
Date: Sat, 27 Oct 2007 08:19:36 -0700
Message-ID: <1193498376.32561.219.camel@razman.gruemaster.com>
References: <877aabc40710260014v220ab804o5de5dbc36b870bd1@mail.gmail.com>
	<20071026091722.GA21274@linux.vnet.ibm.com>
	<20071026155202.GD23016@kroah.com> <s5hzly6nen8.wl%tiwai@suse.de>
	<472220BA.3060201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 54FB92470F
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Oct 2007 17:19:39 +0200 (CEST)
In-Reply-To: <472220BA.3060201@linux.vnet.ibm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, Amit Shah <amitshah@gmx.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

First think I noticed, why are you compiling all the drivers into the
kernel instead of as modules?  Do you need every sound device supported
simultaneously?

Tobin

On Fri, 2007-10-26 at 22:45 +0530, Kamalesh Babulal wrote:

> Takashi Iwai wrote:
> > At Fri, 26 Oct 2007 08:52:02 -0700,
> > Greg KH wrote:
> >> On Fri, Oct 26, 2007 at 02:47:22PM +0530, Kamalesh Babulal wrote:
> >>> I get similar warning, while loading the alsa driver
> >> This is a different problem, not a rename issue like the network one
> >> was.
> >>
> >>> [  191.933548] Advanced Linux Sound Architecture Driver Version 1.0.15
> >>> (Tue Oct 23 06:09:18 2007 UTC).
> >>> [  191.996323] ALSA sound/core/seq/oss/seq_oss.c:232: can't register
> >>> device seq
> >>> [  192.046004] sysfs: duplicate filename 'audio' can not be created
> >>> [  192.086048] WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> >> This is an error in the alsa core, perhaps the alsa developers can help
> >> figure out why they are registering the same file twice?
> > 
> > ALSA core shouldn't do so.  Maybe a built-in OSS driver conflict with
> > ALSA?  We'd need to check .config, then.
> > 
> > 
> > Takashi
> > -
> Hi Takashi,
> 
> Attaching the .config file,
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
