From: "M. Nentwig" <nentwig@users.sourceforge.net>
Subject: RME DSP / Multiface documentation? (hdsp.c)
Date: Tue, 12 Nov 2002 16:40:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD112F4.B4A84A07@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I would like to help with the Hammerfall DSP driver.
Is there any additional technical information? Could someone be so kind
and forward it to me? The driver is easily readable, but it wouldn't
hurt if I had the original documents still.

Two more things:
- The driver uses inlined functions quite extensively. But I think, that
gcc does not inline functions, at least not with -O2 optimization, which
was default (I tried -finline-functions, hdsp.o was different
afterwards).
- In snd_hdsp_interrupt: The first four lines determine, why the
interrupt was triggered (audio, midi0, midi1). Now the MIDI code further
down does not use that information, but the MIDI status instead. Could
that be the cause for the audio dropouts, that happen now and then, when
MIDI is received?

Cheers

Markus




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
