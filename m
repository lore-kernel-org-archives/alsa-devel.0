From: Anders Torger <torger@ludd.luth.se>
Subject: Digital sound card conventions
Date: Fri, 3 Jan 2003 20:44:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301032044.04034.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA06354
	for <alsa-devel@alsa-project.org>; Fri, 3 Jan 2003 20:44:43 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


I'm doing a maintenance update on the rme96 driver, and I wonder if 
there are any conventions to follow in the driver concerning digital 
sound cards.

The specific questions are how to handle sample rates and sound formats 
on the input.

The sound card supports several sample rates and formats. What should 
happen if the user tries to open the input with 48000 kHz ADAT, but the 
format is actually 44100 kHz and SPDIF? I can allow it if I want to, 
the user will get data, but at 48000 kHz of course.

What should happen when there is no input signal at all? The hardware 
supports opening the input, but should I do so in the driver?

The signal can of course change in runtime as well...

I'm thinking of allowing it all, but I don't know if that is the right 
way to go.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
