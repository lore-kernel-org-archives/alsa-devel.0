From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: how to quirk max capture level?
Date: Tue, 21 Jul 2009 11:51:52 +0200
Message-ID: <4A658FB8.9070005@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 3D70C243DD
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 11:51:54 +0200 (CEST)
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

hallo all,
i have Logitech QuickCam E3500 ... with little issue.
Setting capture volume to more then 94% will mute this device... no 
capture will be possible. This device has same issue with windows vista. 
So best way to handle it, is usbquirks.h , but i do not know any way to 
set max level.


amixer report this device like:
=========================================
Simple mixer control 'Mic',0
   Capabilities: cvolume cvolume-joined cswitch cswitch-joined
   Capture channels: Mono
   Limits: Capture 0 - 3072
   Mono: Capture 2950 [96%] [23.00dB] [on]
==========================================

here is alsa-info.sh output:
http://www.alsa-project.org/db/?f=ecd6ea8c7a37c7aa036c88026885f324ef2ab067

As you can see it report it's limits 0-3072 .. but real limit is 0-2943.

Please if any one has some idea, meail me.

Regards,
     Alexey
