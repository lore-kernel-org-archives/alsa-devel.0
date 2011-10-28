From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] [ALSA] hwdep: silence integer overflow
	warning
Date: Fri, 28 Oct 2011 11:55:20 +0300
Message-ID: <20111028085520.GB14900@longonot.mountain>
References: <20111020060910.GA6101@elgon.mountain> <4E9FD02B.6030307@bfs.de>
	<20111028064525.GA14707@longonot.mountain>
	<4EAA5AB7.9000903@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by alsa0.perex.cz (Postfix) with ESMTP id E3B15247E6
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Oct 2011 10:58:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4EAA5AB7.9000903@bfs.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: walter harms <wharms@bfs.de>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 28, 2011 at 09:33:11AM +0200, walter harms wrote:
> 
> 
> Am 28.10.2011 08:45, schrieb Dan Carpenter:
> > On Thu, Oct 20, 2011 at 09:39:23AM +0200, walter harms wrote:
> >> I am not sure how SNDRV_MINOR_HWDEPS is used further
> > 
> > Either device = SNDRV_MINOR_HWDEPS or device = SNDRV_MINOR_HWDEPS + 1
> > are fine (equivalent) but it's a fair point.  Your version is nicer.
> > 
> > I'll redo the patch.
> > 
> 
> An other question is:
> Should the user be informed that the device is modified ?
> The Problem i see is that a user parameter is silently modified
> and buggy code will come through.

That would be an API change.

This is cut and pasted code, and we've had this exact discussion
before for sound/core/rawmidi.c a year ago.  You were involved in
the discussion too.  :P
http://marc.info/?l=kernel-janitors&m=128401699203676&w=2

regards,
dan carpenter
