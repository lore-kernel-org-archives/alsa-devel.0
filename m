From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: hda-intel on Asus M2N-X Plus NVIDIA GeForce
	6100/nForce 430 mobo
Date: Mon, 16 Jun 2008 20:00:02 +0200
Message-ID: <200806162000.02321.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 87461243D7
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 20:00:08 +0200 (CEST)
Received: from [192.168.0.230] (213.36.0.56) by mail.libertysurf.net
	(7.3.118.8) id 484CEE8B00238C02 for alsa-devel@alsa-project.org;
	Mon, 16 Jun 2008 21:05:43 +0200
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

I've just built a new machine, and expected problems with the onboard 
soundcard, and also have problems with the onboard NIC, but that's another 
problem, which is resolved by installing my last remaining realtek 8139 PCI 
card.

Anyway the mobo is an Asus M2N-X Plus NVIDIA GeForce 6100/nForce 430, and the 
Southbridge (which appears to handle allsorts of stuff) is MCP61.

the specs for the soundcard from the Asus site are below.
ALC662 6-Channel High Definition Audio Azalia CODEC
Support Jack-Sensing, Enumeration, Multi-streaming
S/PDIF out on back I/O port

This is using the Fedora 8 distro, which has alsa driver 1.0.15, and is 
probably a bit old. 

The card is not detected at bootup, but I did a modprobe snd-hda-intel, using 
various model options. the modules were loaded, but a cat /proc/asound/cards 
showed "no soundcards detected"

I don't want to waste too much time on this onboard card, and will probably 
buy a cheap well supported card, just to get some sounds on this new machine. 
All the same I've run the alsa-info.sh script, and the link is below.

http://pastebin.ca/1048647

Any comments, as always welcome.

Btw: My other machines use Audigy2 soundblaster (emu10k1) on the first 
machine, and Ensoniq (ens1371) on the other machine, and no problems with 
these cards at all. I cannot repeat my opinions/thoughts about hda-intel 
cards.

Thanks for all your work you folks.

Nigel.
