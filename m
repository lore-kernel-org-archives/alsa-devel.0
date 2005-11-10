From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: Re: lo10K1 not working on x86_64 ?
Date: Thu, 10 Nov 2005 23:24:27 +0100
Message-ID: <20051110232427.0ecb5175@VikingPC.home>
References: <20051102212009.6121d6c3@VikingPC.home>
	<20051103120117.GA27985@skinner.hem.za.org>
	<20051109141310.69fb39f4@VikingPC.home>
	<Pine.LNX.4.61.0511091339240.16661@redshift.mimosa.com>
	<20051109234958.4040a03e@VikingPC.home>
	<Pine.LNX.4.61.0511101158510.16661@redshift.mimosa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511101158510.16661@redshift.mimosa.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Thu, 10 Nov 2005 12:09:32 -0500 (EST)
schrieb "D. Hugh Redelmeier" <hugh@mimosa.com>:

> 
> Great!  Glad to hear that your problem is solved.
> 
> My bug fix came from reading a small code fragment.  I never figured
> out the big picture of what the symptoms would be.  I'd like to know
> if the symptoms you encountered were due to the bug I fixed or due to
> some other change between the earlier version you tested and HEAD.
> 
> It would be great if you would test your working version but with the
> file bitops.h reverted to what it was before the fix (version 1.2).
> 
> I realise that this is asking a lot -- it won't benefit you since you
> already have a working system.  But it should help me understand the
> consequences of the fix.
> 
> Thanks.
> 

Confirmed!

I tried the packpatch to version 1.2 of bitops.h,
with that the error occurs like described, DSP meory gets garbed when a certain
amount or combination of patches is loaded,
resultuing in heavy distorted sound output and non-functioning controls.

(See tar.gz attached to other mail in this thread for DSP patch memory dumps)

With the actual version, no corruption occurs, patches get loaded successfully
and work as expected.

regards

Corvus Corax

PS: thanks for fixing that bug :)


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
