From: Uros Bizjak <uros@kss-loka.si>
Subject: [BUG, patch] AWE64 Full duplex failures
Date: Thu, 7 Nov 2002 13:52:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.05.10211071257010.18843-200000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="46228283-1609572751-1036673133=:18843"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-ID: <Pine.LNX.4.05.10211071349260.6798@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: bmartin@umr.edu
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--46228283-1609572751-1036673133=:18843
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.05.10211071349261.6798@pulsar.kss-loka.si>

Hello!

  This is a solution to an old problem with full duplex on SB16 cards,
described in detail in

http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg02194.html

  The core of this problem is, that ALSA is sending SB_DSP_DMA[8|16]_OFF
0xd0/0xd5 command instead of SB_DSP_DMA[8/16]_EXIT commands 0xda/0xd9.
SB_DSP_DMA*_OFF command in fact only "pause" DMA transfer and does not
clear pending interrupt in sb16 chip. But the problem with
SB_DSP_DMA*_EXIT command is, that it causes unwanted repeat of last period
as SNDRV_PCM_TRIGGER_STOP command is sent after last period. Thus, at the
end of playback/capture, sb16 IRQ will not be acknowledged, and no further
interrupts will occur.

  In a problem description, I can find:

start capture -> ack 16bit IRQ in snd_sb16_setup_rate() function
start playback -> ack 8bit IRQ
stop playback -> 8bit IRQ is pending
stop capture -> 8bit IRQ is pending

start playback -> clear 16bit IRQ

In this state, 8bit IRQ is still pending! It looks that with some SB DSP
chip versions, this will block generation of 8 _and_ 16bit IRQs.

Attached patch (untested!) acknowledges [16|8] bit interrupt, but adds
[8|16] bit acknowledge, if secondary channel is not in use at the moment.

Please, could someone with described problems test this patch.

  Another problem, described in

http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg04960.html

  is perhaps connected with the way sb16 driver reports mutual sample
rate, when one channel is already in use. Locked rate will be reported
only when second channel is opened, so it is possible that selected rate
won't be programmed to sb16 chip if capture and playback channels are
opened simultaneously and no playback/capture has started yet.

	Uros.

--46228283-1609572751-1036673133=:18843
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="sb16.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.05.10211071345330.18843@pulsar.kss-loka.si>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="sb16.diff"

SW5kZXg6IHNiMTZfbWFpbi5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9hbHNhLWtlcm5lbC9pc2Evc2Ivc2Ix
Nl9tYWluLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEyDQpkaWZmIC11
IC1yMS4xMiBzYjE2X21haW4uYw0KLS0tIHNiMTZfbWFpbi5jCTIzIE9jdCAy
MDAyIDE5OjA3OjQ0IC0wMDAwCTEuMTINCisrKyBzYjE2X21haW4uYwk3IE5v
diAyMDAyIDEyOjIzOjA5IC0wMDAwDQpAQCAtMjI0LDEwICsyMjQsMzAgQEAN
CiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiANCiAJc3Bpbl9sb2NrX2lycXNh
dmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7DQotCWlmIChjaGlwLT5tb2Rl
ICYgKGNoYW5uZWwgPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSyA/IFNC
X01PREVfUExBWUJBQ0tfMTYgOiBTQl9NT0RFX0NBUFRVUkVfMTYpKQ0KLQkJ
c25kX3NiX2Fja18xNmJpdChjaGlwKTsNCi0JZWxzZQ0KLQkJc25kX3NiX2Fj
a184Yml0KGNoaXApOw0KKw0KKwkvKiBhY2tub3dsZWRnZSBzdGFsbGVkIGlu
dGVycnVwdHMgKi8NCisJaWYgKHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJW
X1BDTV9TVFJFQU1fUExBWUJBQ0spIHsNCisJCWlmIChjaGlwLT5tb2RlICYg
U0JfTU9ERV9QTEFZQkFDS18xNikgew0KKwkJCXNuZF9zYl9hY2tfMTZiaXQo
Y2hpcCk7DQorCQkJaWYgKCEgKGNoaXAtPm1vZGUgJiBTQl9SQVRFX0xPQ0tf
Q0FQVFVSRSkpDQorCQkJCXNuZF9zYl9hY2tfOGJpdChjaGlwKTsNCisJCX0g
ZWxzZSB7DQorCQkJc25kX3NiX2Fja184Yml0KGNoaXApOw0KKwkJCWlmICgh
IChjaGlwLT5tb2RlICYgU0JfUkFURV9MT0NLX0NBUFRVUkUpKQ0KKwkJCQlz
bmRfc2JfYWNrXzE2Yml0KGNoaXApOw0KKwkJfQ0KKwl9IGVsc2Ugew0KKwkJ
aWYgKGNoaXAtPm1vZGUgJiBTQl9NT0RFX0NBUFRVUkVfMTYpIHsNCisJCQlz
bmRfc2JfYWNrXzE2Yml0KGNoaXApOw0KKwkJCWlmICghIChjaGlwLT5tb2Rl
ICYgU0JfUkFURV9MT0NLX1BMQVlCQUNLKSkNCisJCQkJc25kX3NiX2Fja184
Yml0KGNoaXApOw0KKwkJfSBlbHNlIHsNCisJCQlzbmRfc2JfYWNrXzhiaXQo
Y2hpcCk7DQorCQkJaWYgKCEgKGNoaXAtPm1vZGUgJiBTQl9SQVRFX0xPQ0tf
UExBWUJBQ0spKQ0KKwkJCQlzbmRfc2JfYWNrXzE2Yml0KGNoaXApOw0KKwkJ
fQ0KKwl9DQorDQogCWlmICghKGNoaXAtPm1vZGUgJiBTQl9SQVRFX0xPQ0sp
KSB7DQogCQljaGlwLT5sb2NrZWRfcmF0ZSA9IHJhdGU7DQogCQlzbmRfc2Jk
c3BfY29tbWFuZChjaGlwLCBTQl9EU1BfU0FNUExFX1JBVEVfSU4pOw0K
--46228283-1609572751-1036673133=:18843--


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
