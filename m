From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: SoundScape driver... FIXMEs
Date: Sun, 22 Sep 2002 20:09:52 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020922190952.73991.qmail@web40607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I saw the SoundScape PnP driver appear in CVS today,
along with a number of FIXMEs at the top of the file.
I presume that these FIXMEs are a barrier to fully
integrating the driver, and that's what you mean by
"deadlock for alsa-kernel"?

Anyway:
- the CONFIG_SND_OSSEMUL dependency was a holdover
from my development cycle and can be removed. It was
placed there to guarantee that I was correctly
including my current ALSA configuration. (Previously,
I had been loading a non-OSS-enabled snd-sscape.o
module into an OSS-enabled ALSA setup. And since
struct _snd_card is different depending on whether OSS
emulation has been enabled or not, this was causing
strange memory errors.) My snd-sscape.o works just
fine with native alsa-utils, and so OSS emulation is
definitely an optional extra.

- a non-modular build wasn't a priority because I was
under the impression that one of the goals for Linux
2.5+ was to *remove* all compiled-in drivers? However,
I could probably provide something, if absolutely
necessary. 

- I was not aware that "verify_area()" had been
deprecated. There were no comments to this effect in
the <asm/uaccess.h> header, and a grep through the
2.4.19 tree shows that it is HEAVILY used. In fact,
verify_area() appears to be the public interface for
the same access-checking function invoked by
copy_from_user() and copy_to_user(). The point about
calling verify_area() at all is to validate the entire
DMA upload block at once, so that I can safely copy it
piecemeal later. It seems to be more efficient to DMA
directly from userspace rather than copying the block
into *more* temporary storage and then DMA-ing from
there. Is there a race condition between the
verify_area() and the underlying __copy_from_user()?
If so, then how is this same race resolved by
copy_from_user()?

Anyway, thanks for merging the driver,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
