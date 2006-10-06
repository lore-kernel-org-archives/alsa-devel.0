From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.13 and hdsp cardbus
Date: Fri, 6 Oct 2006 11:27:50 +0400
Message-ID: <70a871c80610060027l4196fdfi7b7ecd215733a7b3@mail.gmail.com>
References: <70a871c80610050541r73bbc2d7j408595802bb2c43f@mail.gmail.com>
	<4525F73D.2040105@chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4525F73D.2040105@chello.at>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Karl Grill <kgrill@chello.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/6/06, Karl Grill <kgrill@chello.at> wrote:
> that's interesting - I saw the same problem, but attributed it to the
> fact that
> my iobox is the (currently unsupported) hdsp rpm and that the cardbus
> card is revision 15 (also currently unsupported). You didn't do a
> firmware upgrade on the card, did you? Anyway, could you send me some
> more information (like lspci, dmesg output, at least what you can get in
> spite of the freeze).

I do not reflashed the card. But bought it recently, it may be of the
newest revision.
lspci gives:
02:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 35)

It turns out, the freeze is on cardbus ejection.
Stack trace (hand-rewritten from the screen):

Call trace:
:snd_hdsp:snd_hdsp_midi_input_read + 0x29/0xfd
:snd_hdsp:hdsp_midi_tasklet + 0x13/0x28
tasklet_hi_action+0x3d/0x65
__do_softirq+0x49/0x9c
call_softirq+0x1c/0x28

DWARF2 unwinder stuck at call_softirq
Leftover inexact backtrace:

<IRQ> do_softirq
irq_exit
do_IRQ
default_idle
ret_from_intr
<EOI>udp_poll
default_idel
cpu_idel
start_kernel
_sinittext

Kernnel panic - not syncing: Aiee, killing interrupt handler!


Hope this will help.

Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
