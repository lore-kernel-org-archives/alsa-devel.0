From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: New ALSA CVS : no sound with aplay?
Date: Sat, 21 Sep 2002 19:11:43 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020921181143.7951.qmail@web40613.mail.yahoo.com>
References: <Pine.LNX.4.33.0209211956050.815-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209211956050.815-100000@pnote.perex-int.cz>
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

On Friday 20 September 2002 20:18, Chris Rankin wrote:
> I have installed the brand new libasound.so.2 and
> compiled the CVS alsa-utils against it. However, the
> new aplay binary just "hangs" and does not make any
> sound. The old aplay works against the new
> libasound.so.2 just fine.

 --- Jaroslav Kysela <perex@perex.cz> wrote: > On Sat,
21 Sep 2002, Niek van der Maas wrote:
> Fixed. I'm sorry for this problem.

Heh, not fixed yet ... ;-). I've recompiled alsa-lib
and installed it, and also recompiled the alsa-utils.
The rc3 utils still work fine, but the new utils now
give this error:

$ aplay /usr/lib/sounds/jungle_exit.wav 
Playing WAVE '/usr/lib/sounds/jungle_exit.wav' :
Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
aplay: set_params:813: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: NONE
PERIOD_TIME: (682666 682667)
PERIOD_SIZE: (91853300 91853301)
PERIOD_BYTES: (367413200 367413204)
PERIODS: (1 2)
BUFFER_TIME: (682666 682667)
BUFFER_SIZE: 91853389
BUFFER_BYTES: 367413556
TICK_TIME: 10000

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
