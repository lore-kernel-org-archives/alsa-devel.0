From: Don Mackie <rebirth@orcon.net.nz>
Subject: Re: Question - selecting soundfonts/banks
Date: Sat, 22 May 2004 11:35:17 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40AE9235.50307@orcon.net.nz>
References: <40AD8921.8000503@orcon.net.nz> <200405211000.49078.holborn@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405211000.49078.holborn@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

holborn wrote:

 >>Hi,
 >>
 >>Can someone please explain to me the relationship between midi
 >>bank_msb/bank_lsb_prognum, and soundfontnum/bank_lsb/prognum on
 >>fluidsynth?

 > Read this:
 >
 > http://mail.gnu.org/archive/html/fluid-dev/2003-07/msg00029.html
 >
 > maybe can help you.

Thanks, but that didn't get me any further - I can already select banks 
on fluidsynth and emu10k1

What I'm asking is - how do I assign a midi channel to a particular 
voice on a particular bank *within a particular soundfont* ?

So if fluidsynth, or my emu10k1 card, has two or more sound fonts 
loaded, I want to be able to access banks/voices on different soundfonts 
at the same time.

For instance:
  - channel 1 -> font fluid-gm.sf2, bank 000, prog 001
  - channel 2 -> font 2rock9.sf2, bank 008, prog 011
  - ...

I've tried to do this via bank msb, bank lsb and prog change messages 
from my midi keyboard, as well as sending bank msb/lsb controller (and 
prog change) events via the alsa-seq api, but (with fluidsynth at 
least), things are totally not working as one would expect.

Any more suggestions?

Cheers
D



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
