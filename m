From: Anders Torger <torger@ludd.luth.se>
Subject: How to support multiple open in low-level driver
Date: Fri, 3 Jan 2003 23:37:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301032337.37262.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA08907
	for <alsa-devel@alsa-project.org>; Fri, 3 Jan 2003 23:38:14 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


I have noticed that some (most) low level drivers support multiple open, 
that is a sound card which is already opened, can be opened again.

I noticed that also my rme96 driver supported this sort of, although it 
probably does not feel very good about it. If the sound card is in ADAT 
mode, it is not so good if it is reopened in SPDIF mode from another 
application for example.

I'd like to just return -EBUSY if it is already open, is that ok?

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
