From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: compiling pcm_jack fails
Date: Fri, 7 Mar 2003 12:45:25 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030307124525.74588.qmail@web40606.mail.yahoo.com>
References: <200303070935.39202.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303070935.39202.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko.Prattala@Helsinki.FI, Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I don't have jack installed either, reran the
cvscompile script in alsa-lib and *still* had a build
failure. Sounds like a bug to me. There's no reason
ALSA should expect to find jack.

Chris

 --- Jaakko Prättälä <Jaakko.Prattala@Helsinki.FI>
wrote: > On Friday 07 March 2003 00:10, Martin Langer
wrote:
> > using latest CVS on a jack-free system produces a
> lot of output.
> Do you mean you don't have jack installed?
> I think the next refers to the jack.h that comes
> with jack
> > pcm_jack.c:36: jack/jack.h: No such file or
> directory
> Just a guess, though.

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
