From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Where is the real developers list?
Date: Fri, 11 Jul 2003 02:03:51 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307110155210.5612-100000@ecabase.localdomain>
References: <20030710222020.GA20402@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030710222020.GA20402@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Jul 2003, Carlo Wood wrote:

> ViaVoice assume the OSS interface - and I need it work with
> ALSA.  That SHOULD not be a problem because ALSA supports
> OSS - but in practise: it doesn't work.

ALSA's OSS emulation is very good, but not perfect. There are quite a few 
apps that use the OSS API in strange ways and it's difficult to support 
all variations (search the ALSA mailing archives for Quake for example). 

> I believe that this is a bug in ALSA, or at least in the
> portion that support/emulates OSS.
[...]
> I cannot change ViaVoice because it is closed software.
> I cannot write to IBM and request help: they don't support
> this anymore.

Yup, I guess if the ALSA developers are at LinuxTag, you'll have to wait a
while before they can give the definitive answer.

> I wrote a simple test case that reproduces the exact
> problem (at least, on my PC, with a Create SB Live! Value).
> See a previous mail of me with the Subject
> "Bug in OSS simulation (ALSA 0.9.4)"

Sorry about that, you had indeed already posted the test case. I'll
comment on the test case in a separate mail.

> To my suprise I saw on the webpage of alsa that I'd need
> 0.9.4 as the version that supports OSS.  Does this mean
> that 0.9.5 does NOT support OSS at all anymore ?!?

Nope, it still does. Emulating OSS is an important feature for ALSA as it
is needed for ALSA to replace the OSS drivers in the Linux kernel.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
