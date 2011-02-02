From: "Sebastian H." <vand2@gmx.de>
Subject: alsa-lib TLVs and valgrind
Date: Wed, 02 Feb 2011 12:54:34 +0100
Message-ID: <4D4945FA.4030506@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id C8930103816
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 12:59:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hello list

I'm about to release a new version of alsamixer-qt4
(now named qasmixer) and ran the program through valgrind.

valgrind --track-origins=yes src/qasmixer &> valgrind.log


The log file contains tons of warnings like this

==3432== Conditional jump or move depends on uninitialised value(s)
...
... (qasmixer function calls)
...
==3432==  Uninitialised value was created by a heap allocation
... malloc (vg_replace_malloc.c:236)
... init_db_range (simple_none.c:1111)
... get_dB_range (simple_none.c:1156)
... get_dB_range_ops (simple_none.c:1173)
... snd_mixer_selem_get_playback_dB_range (simple.c:298)
...
... (qasmixer function calls)
...

The fresh alsa-lib-10-24.1 was used for this, compiled with debug
symbols enabled. Drivers are from Debian/squeeze.

This issue doesn't seem critical for the application but it totally
floods the valgrind.log file.

Best,
Sebastian Holtermann
