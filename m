From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: alsa 1.0.5rc1: envy24control not compileable
Date: Fri, 28 May 2004 14:44:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405281444.23578.loritz@fh-furtwangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA15205
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2004 14:46:43 +0200
Received: from A36de.a.pppool.de (A36de.a.pppool.de [213.6.54.222])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i4SCkdJg016094
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2004 14:46:40 +0200 (MEST)
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

It seems that in the package alsa-tools-1.0.5rc1 a file is missing.
envy24control can't be compiled. Output:
...
In file included from envy24control.c:23:
envy24control.h:27:22: profiles.h: Datei oder Verzeichnis nicht gefunden
envy24control.c: In function `index_active_profile':
envy24control.c:1686: error: `NOTFOUND' undeclared (first use in this 
function)
envy24control.c:1686: error: (Each undeclared identifier is reported only once
envy24control.c:1686: error: for each function it appears in.)
envy24control.c: In function `delete_card_number':
envy24control.c:1713: Warnung: passing arg 2 of `gtk_entry_set_text' makes 
pointer from integer without a cast
envy24control.c: In function `restore_active_profile':
envy24control.c:1726: error: `ALSACTL_OP_RESTORE' undeclared (first use in 
this function)
envy24control.c: In function `save_active_profile':
envy24control.c:1739: error: `ALSACTL_OP_STORE' undeclared (first use in this 
function)
envy24control.c: In function `entry_toggle_editable':
envy24control.c:1768: error: `NOTFOUND' undeclared (first use in this 
function)
envy24control.c: In function `create_profiles':
envy24control.c:1853: Warnung: assignment makes pointer from integer without a 
cast
make: *** [envy24control.o] Fehler 1

(first line "envy24control.h:27:22: profiles.h: Datei oder Verzeichnis nicht 
gefunden" 
means: "file not found")

other than that, compilation for ice1712 and intel8x0 went fine.

keep up the good work!

Mario Loritz



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
