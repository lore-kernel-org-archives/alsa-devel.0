From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: alsa 1.0.5 does not start modules
Date: Sun, 30 May 2004 16:45:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405301645.39005.loritz@fh-furtwangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07980
	for <alsa-devel@alsa-project.org>; Sun, 30 May 2004 16:48:37 +0200
Received: from B7502.b.pppool.de (B7502.b.pppool.de [213.7.117.2])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i4UEmXZf020106
	for <alsa-devel@alsa-project.org>; Sun, 30 May 2004 16:48:33 +0200 (MEST)
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello list,

after compiling the new 1.0.5 packages, the sound modules
do nor start correctly, resulting in an unbootable system,
or more correctly an unrebootable system.

The system hangs after, in my case, both sound card modules
loaded ("loading snd-intel8x0  done loading snd-ice1712  done").
The booting process stops there without further notice from
the kernel. When I try to reboot from there  by "ctrl-alt-del" the 
shutdown process stops, when the sound drivers are tried
to be shutdown. The system is not freezed but unusable.
I can switch consoles but not log in anymore (consoles are
probably already shut down).

I have no idea if or how I can get some appropriate logfiles
for this problem.

I downgraded to alsa 1.0.5rc1 again, which works fine.

However, I kept envy24control from alsa-tools-1.0.5,
which is compileable and solved my problem from
yesterday...

Please ask for logfiles specifically (how to make and where to find), 
if someone needs them.

Greetings, 
Mario Loritz

System Information:
SuSE-Linux 9.0 kernel 2.4.21-215-athlon
Realtek ALC655
Hoontech DSP24
Athlon64, nforce-Chipset



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
