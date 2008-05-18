From: Travis Place <wishie@wishie.net>
Subject: Incorrect model selection for HDA Intel based card.
Date: Mon, 19 May 2008 04:19:14 +1000
Message-ID: <200805190419.14316.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-99-066.dial.usertools.net [202.137.99.66])
	by alsa0.perex.cz (Postfix) with ESMTP id E9EE124357
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 20:19:31 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 965E331C24
	for <alsa-devel@alsa-project.org>; Sun, 18 May 2008 18:40:39 +1000 (EST)
Content-Disposition: inline
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

Just had a user in #alsa on freenode, with an Asus P5GD1 mainboard.
They couldnt seem to get surround sound working at all.
It has an ALC880 based HDA-Intel sound device on board.

Now, the problem lies in the Susbsystem ID's (1043:814e).
These match in patch_realtek.c as follows:

SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS)

The users mainboard (The ASUS P5GD1) actually has 6 output jacks, aswell as 
SPDIF, not the standard 3-jacks that the "ASUS" model quirk implies.

I talked this user through forcing the driver to use '6stack-digout' for his 
sound device, and things all work fine now.

Below is a link to his alsa-info output, with the problem fixed. (so you can 
check IDs etc)

http://pastebin.ca/1022042

Up until this point, i hadnt come across a wrong detection like that. Is there 
anyway to differentiate this users card from the normal "3stack" model that 
actually requires the "ASUS" model quirk ?

Thanks,
Travis Place

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
