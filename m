From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: AD1988B: ALSA doesn't use dmix automatically
Date: Sat, 15 Mar 2008 23:48:52 -0300
Message-ID: <20080315234852.25288ff8@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F0352450B
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 03:50:10 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jaiwp-0004M4-AO
	for alsa-devel@alsa-project.org; Sun, 16 Mar 2008 02:50:07 +0000
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 02:50:07 +0000
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 02:50:07 +0000
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

ALSA 1.0.15

http://alsa.opensrc.org/index.php/Dmix

NOTE: For ALSA 1.0.9rc2 and higher you don't need to setup dmix. Dmix
is enabled as default for soundcards which don't support hw mixing.

	So why if I try to play 2 sounds at the same time, the second
one complains the "resource is busy"? Shouldn't it detect that AD1988B
can't do hardware mixing and use dmix automatically? 

	Obs.: I don't have any ~/.asoundrc or /etc/asound.conf lying
around.

	Thanks!

-- 
Linux 2.6.24: Arr Matey! A Hairy Bilge Rat!
http://u-br.net http://www.abusar.org/FELIZ_2008.html
Napalm Death - "Circle Of Hypocrisy" (Harmony Corruption - 1990)
