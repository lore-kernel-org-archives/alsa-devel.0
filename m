From: =?iso-8859-1?q?Evghenii=20Gaburov?= <alsa_eg35@yahoo.co.uk>
Subject: SIS7012 and alsa >= 0.9.7
Date: Wed, 14 Jan 2004 17:24:17 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040114172417.99270.qmail@web25007.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

There is a problem with alsa-driver with versions >=
0.9.7 on my card SIS7012; the last working version was
0.9.6. All further versions have too fast playback,
and sending option "ac97_clock=48000" does not change
anythin. Actually, it does changes, but not that I
expected - playback is still fast, but with low
quality if one sends a low value, say
"ac97_clock=8000".

Comparison of 0.9.7 (first non-working) against 0.9.6
(last working) reveals that a slightly differnt
interrupt handler was used ("snd_intel8x0_update" in
alsa-kernel/pci/intel8x0.c). It turns out that seting
variable "step=1" right before "ichdev->position +=
step * ichdev->fragsize1" solves the problem, and
driver work fine. This also work with the latest
realese, that is alsa-1.0.1. 

I am not a driver developer and have no idea what is
the problem, but it would be great if this can be
fixed in all future versions of alsa.

Regards,
 Evghenii Gaburov


________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
