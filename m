From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Where is the real developers list?
Date: Fri, 11 Jul 2003 00:20:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710222020.GA20402@alinoe.com>
References: <20030710120333.GA15534@alinoe.com> <Pine.LNX.4.44.0307101722110.7662-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307101722110.7662-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Kai,

thanks for the extensive answer.

Maybe I am a little impatient, thats true.  Sorry about that.

However, I am not really doing this formyself, but for
many other people who now are relying on.

The problem is to get an old, unmaintained and closed
software application working: IBM's ViaVoice.  This is
the ONLY speech recognition software that works reasonable
for linux.  Other people are working on writing open source
speech recognition software, but that is not a trivial
things and in the mean time many people need this ViaVoice
thing to work.

ViaVoice assume the OSS interface - and I need it work with
ALSA.  That SHOULD not be a problem because ALSA supports
OSS - but in practise: it doesn't work.

I believe that this is a bug in ALSA, or at least in the
portion that support/emulates OSS.

I cannot change ViaVoice because it is closed software.
I cannot write to IBM and request help: they don't support
this anymore.

What is left is to figure out why ALSA fails to emulate
OSS in this particular case.

I wrote a simple test case that reproduces the exact
problem (at least, on my PC, with a Create SB Live! Value).
See a previous mail of me with the Subject
"Bug in OSS simulation (ALSA 0.9.4)"

To my suprise I saw on the webpage of alsa that I'd need
0.9.4 as the version that supports OSS.  Does this mean
that 0.9.5 does NOT support OSS at all anymore ?!?

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
