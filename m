From: jakubpol <jakubpol@poczta.onet.pl>
Subject: Audigy ES
Date: Wed, 29 Sep 2004 23:43:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409292343.19738.jakubpol@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello. I've just bought an Audigy ES card. I've read a lot of *very* negative 
things about the Audigy LS so I tried to stay away from it as far as 
possible. The ES card is, however, based on the Audigy chip (it also costs 
half of the price of the LS). I used the snd-emu10k1 module (I had it already 
compiled because I previously had a SB Live card) and simple playback on 2 
speakers works beautifully. I filed a bug report so that it is added to the 
sound matrix (the LS card should also be added, I think).

Here's the output of lspci -vn for that card:

0000:00:0f.0 Class 0401: 1102:0004 (rev 03)
        Subsystem: 1102:0052
        Flags: bus master, medium devsel, latency 32, IRQ 7
        I/O ports at c800
        Capabilities: [dc] Power Management version 2

And lspci -v:

0000:00:0f.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs: Unknown device 0052
        Flags: bus master, medium devsel, latency 32, IRQ 7
        I/O ports at c800
        Capabilities: [dc] Power Management version 2

Now, there is one thing I can't figure out (please do not laugh at me). When I 
had the Live card, I had my 2 speakers and my headphones plugged in the 2 
first 'holes' at the back of the card and both the speakers and the 
headphones worked (I used the 'Wave Surround' slider for the headphones). Now 
with the Audigy ES there is no 'Wave Surround'. I tried various sliders, also 
looked for info and will look more if somebody tells me it is possible. I 
know I should post this part of my message on the alsa-users mailing list but 
since the card is not officially supported I do not even know if this should 
work.

I also want to thank all the developers for your great work. I can't express 
how happy I am that this card is supported.

Jakub


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
