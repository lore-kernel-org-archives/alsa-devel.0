From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: HG branches
Date: Wed, 06 Feb 2008 21:06:57 +0100
Message-ID: <47AA1361.7070201@keyaccess.nl>
References: <s5hwspjzbt0.wl%tiwai@suse.de>	<Pine.LNX.4.61.0802061437190.8113@tm8103.perex-int.cz>
	<Pine.LNX.4.61.0802061505470.8113@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ABBB103933
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 21:05:51 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0802061505470.8113@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06-02-08 15:06, Jaroslav Kysela wrote:

> BTW: Does anyone know if it's possible to just pick a patch from a HG 
> branch to another? STG (Stacked GIT) has nice 'stg pick <branch>@<patch>'
> command for this.

Not me, but thought I'd take the opportunity to ask if switching to git is 
(still) an absolute no. As far as I can see, hg has mostly downsides, with 
needing a conduit between it and upstream for example that I saw Linus 
complain about recently.

I'm used to git by now, and every time I try do something inside ALSA I just 
keep on typing the wrong commands to hg, needing the manpage, not being 
certain that I'm not fucking up my local tree...

I can definitely say that hg is not being instrumental in making me more of 
a contributor. When I _do_ do something I tend to just work against the 
kernel inside git and then only in the end apply the result to the current 
hg just to see if it will.

I believe the git submodule stuff would also nicely allow all of ALSA to be 
one giant repo basically, with kernel, lib, ..., as submodules.

Rene.
