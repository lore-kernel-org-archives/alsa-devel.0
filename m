From: Zbigniew Baniewski <zb@ispid.com.pl>
Subject: Audigy: recording level much too low (microphone)
Date: Fri, 10 Aug 2007 13:02:17 +0200
Message-ID: <20070810110217.GA7011@sarge.my.own.domain.no-net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from v05705.home.net.pl (v05705.home.net.pl [212.85.118.117])
	by alsa0.perex.cz (Postfix) with SMTP id 5D2F7243A1
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 13:02:22 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo,

I've got a problem with Audigy (it's SB0230 release) soundcard: the
recording level, when taking the sound from microphone, is much too low.

I've sent a mail to "users" list, so here I'm just pointing to that mail:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg20235.html
...and so I won't repeat it all here.
(I made a mistake in the subject there, writing about "Audigy2")

My card is seen by 1.0.14 ALSA as ( cat /proc/asound/cards ):

0 [Audigy   ]: Audigy - Audigy 1 [Unknown]
               Audigy 1 [Unknown] (rev.3, serial:0x5a1102) at 0xc400, irq 11


As I understand, there is some variable (or register?), which controls that
recording level for microphone input - perhaps someone of the developers
could tell me, which variable is it, and which file should I search? In such
way perhaps I could fix it on my own - just by setting higher max. level, or
in similar way. But searching all that files on my own could take serious
amount of time, I'm afraid.

Or perhaps there's another way to fix it (some special settings)?
-- 
				pozdrawiam / regards

						Zbigniew Baniewski
