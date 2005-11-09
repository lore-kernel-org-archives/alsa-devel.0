From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: Re: lo10K1 not working on x86_64 ?
Date: Wed, 9 Nov 2005 23:49:58 +0100
Message-ID: <20051109234958.4040a03e@VikingPC.home>
References: <20051102212009.6121d6c3@VikingPC.home>
	<20051103120117.GA27985@skinner.hem.za.org>
	<20051109141310.69fb39f4@VikingPC.home>
	<Pine.LNX.4.61.0511091339240.16661@redshift.mimosa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511091339240.16661@redshift.mimosa.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Cc: alsa-devel@lists.sourceforge.net, Peter Zubaj <pzad@pobox.sk>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>
List-Id: alsa-devel@alsa-project.org

Am Wed, 9 Nov 2005 13:47:55 -0500 (EST)
schrieb "D. Hugh Redelmeier" <hugh@mimosa.com>:

> 
> I know nothing about what ld10k1 does nor have I run it, but I did
> submit some fixes to its code.  These fixes correct a bug that would
> manifest itself on x86_64.  They are now in CVS (as of today).
> 
> See https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1533
> 
> Perhaps this fixes the problems you observed.  I have no way of
> knowing.  You might consider testing HEAD.
> 

Confirmed, the problem seems NOT to occur with ld10k1 compiled from the current
CVS HEAD

init_live now produces a working routing.

Thanks all for your help :-))


best regards


Corvus Corax


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
