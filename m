From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 22:30:46 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020918213046.31539.qmail@web40605.mail.yahoo.com>
References: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@perex.cz> wrote: > On Wed,
18 Sep 2002, [iso-8859-1] Chris Rankin
> wrote:
>> It seems, that you're not understand the
> compatibility.

That's possible - or maybe the existing
"compatibility" is woefully inadequate for the scale
of the problem?

The applications that I am trying to compile with the
compatibility library are the CVS versions of wine and
xine!!! I can't just recompile them and forget about
them because I need the compatibility headers
installed so that I can KEEP recompiling them as I
update them! However, the ALSA utilities don't compile
against the compatibility headers because they are
incompatible!

The possible solutions from my perspective are:
- I install BOTH libraries, each with full headers
(somehow)
- I backport the ALSA utilities to work with the old
API
- I forward port xine and wine to the new API myself
- You back out the incompatible API.

Sincerely,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
