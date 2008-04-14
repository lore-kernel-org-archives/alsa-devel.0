From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 18:58:11 +0200
Message-ID: <20080414165811.GG22115@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <20080412214143.GB2828@localhost>
	<48012FD7.6050904@superbug.co.uk> <48013316.80806@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E626245B7
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 18:58:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48013316.80806@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 13.04.08 00:09, Rene Herman (rene.herman@keyaccess.nl) wrote:

> 
> On 12-04-08 23:55, James Courtier-Dutton wrote:
> 
> > Most consumer distos do not agree with me and want the volume turned up 
> > already by default. The problem is deciding on a generally good level for
> > these distros.
> 
> I believe it can be concluded that there is no "generally good level". ALSA 
> should ship /usr/share/alsa/cards/<card>.state files which at least lets a 
> driver author decide on a sensible set of default mixer settings.

Yet another file that needs to be maintained.

Why not export this data like all the other data from the kernel? That
way other apps (not just alsactl) could make use of this information. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
