From: Laurent Epinat <l.epinat@free.fr>
Subject: New sound device question
Date: Fri, 24 Dec 2010 14:41:29 +0100
Message-ID: <4D14A309.9030603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 06D19103800
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 14:41:00 +0100 (CET)
Received: from [192.168.1.2] (unknown [82.239.195.157])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 7846182258
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 14:40:57 +0100 (CET)
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

Hello All

I'm a newbie in this group and the sound systems.

I try to developpe a usb sound driver for a Alesis Multix 8 USB2.0

http://www.alesis.com/multimix8usb20

The output interface is allready fonctional, but the Input not :-(
Because there is 2 end point for it. The first one is on Isochronous 
mode and the other is on Bulk mode

I don't know how to declare the second endpoint in the quirks_table.


Where can I get a good documentation or help about the alsa USB sound 
structure.

The only informations I have about the devices, are dump from windows


thanks




-- 
Salutations
                           __
  /----------------\      |~~\______/====\__  |
(  Laurent Epinat  )----  \LE______======= )-+
  \----------------/               ----|/--   |
mailto:l.epinat@free.fr              (O)
http://lepinat.free.fr
