From: Simon Bucher <DocBexter@gmx.net>
Subject: X-Runs
Date: Sun, 14 Sep 2003 00:38:26 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <19535.1063492706@www15.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
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

Im new to Alsa and my current code basically just uses the simple
input/output examples for Full Duplex io. It works really well ... the latency is <=
0.5ms without underruns except in two situations:

Disk IO:
Only a small disk access ruins the stream - is there a way to disable disk
io while the app is running ? I really dont need the disk ( no swap and so on
... )

Scrolling up in "mcedit" ( == small coloured text editor ) also gives me a
100% underun.
How can this be ? Im using sched_fifo @ 99 and a small text editor preempts
my code ?!

greetz
Simon

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
