From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and
Date: Wed, 1 Mar 2006 12:22:34 +1030 (CST)
Message-ID: <200603010152.k211qYq0029665@auster.physics.adelaide.edu.au>
References: <1141172997.5860.70.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141172997.5860.70.camel@mindpipe> from "Lee Revell" at Feb 28, 2006 07:29:57 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Rimas Kudelis <rq@akl.lt>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Lee

> On Wed, 2006-03-01 at 10:52 +1030, Jonathan Woithe wrote:
> > Not sure, since we don't yet know for sure that this is the problem with
> > the 1641 etc.  It *might* still be due to a gremlin lurking in the
> > ALC260 code.  To prove this we probably need someone with the laptops
> > affected by #1843 and #1847 to test both modes of WMP and report their
> > findings.
> 
> Actually I was wondering if these are related to the original bug from
> #1618 not the CD issue.

Ah, oops, sorry.

> Do your patches have any effect on Acer machines with HDA intel codecs
> other than the ALC260?

No.  They only apply to Acer machines with a Realtek ALC260 codec.  Even
if they have a Realtek codec, if it's not an ALC260 then the latest patches
don't apply to the machine.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
