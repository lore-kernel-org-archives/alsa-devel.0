From: walter harms <wharms@bfs.de>
Subject: Re: [patch] [ALSA] hwdep: silence integer overflow
	warning
Date: Fri, 28 Oct 2011 09:33:11 +0200
Message-ID: <4EAA5AB7.9000903@bfs.de>
References: <20111020060910.GA6101@elgon.mountain> <4E9FD02B.6030307@bfs.de>
	<20111028064525.GA14707@longonot.mountain>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.sz.bfs.de (mx01.sz.bfs.de [194.94.69.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 463BC247AA
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Oct 2011 09:33:15 +0200 (CEST)
In-Reply-To: <20111028064525.GA14707@longonot.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 28.10.2011 08:45, schrieb Dan Carpenter:
> On Thu, Oct 20, 2011 at 09:39:23AM +0200, walter harms wrote:
>> I am not sure how SNDRV_MINOR_HWDEPS is used further
> 
> Either device = SNDRV_MINOR_HWDEPS or device = SNDRV_MINOR_HWDEPS + 1
> are fine (equivalent) but it's a fair point.  Your version is nicer.
> 
> I'll redo the patch.
> 

An other question is:
Should the user be informed that the device is modified ?
The Problem i see is that a user parameter is silently modified
and buggy code will come through.

re,
 wh
