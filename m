From: Richard Bown <bownie@bownie.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 11:25:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209181125.44990.bownie@bownie.com>
References: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz> <200209181046.42341.bownie@bownie.com> <s5hwupjr4rm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from msgdirector2.onetel.net.uk (IDENT:mirapoint@msgdirector2.onetel.net.uk [212.67.96.149])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA18725
	for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2002 12:24:35 +0200
In-Reply-To: <s5hwupjr4rm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 18 September 2002 11:06, Takashi Iwai wrote:
> > Wake me up when it's all over.
>
> please give comments before going to bed.
> (otherwise you will lose the right to whinge ;)
> the decision should not be done self-righteously.

I know that you and Jaroslav will come to a fair an equitable decision without me
muddying the waters..

..however, after thinking about it (and since you asked) I think it makes more sense to
do what you're suggesting and keep the old API in addition to the new one and just mark
the old one as deprecated for the next release or three.  Then you can phase out the old
interface in (say) six months time or something.  The thing shouldn't just break though
and I agree with what you're saying about #ifdefs - there are enough of those about as
it stands without adding more to the pile.

Anyway, just my 2c.
 
And so to bed.

B


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
