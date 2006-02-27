From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Mon, 27 Feb 2006 23:08:10 +0000
Message-ID: <1141081690.9257.1.camel@localhost.localdomain>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
	 <20060227172601.GA446@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DE582179
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 00:08:13 +0100 (MET)
In-Reply-To: <20060227172601.GA446@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-02-27 at 18:26 +0100, Clemens Ladisch wrote:

> 
> ALSA will notice that something has been played when the return value of
> the pointer callback changes.
> 

Testing shows that it does change...

ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x23
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x4B
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x73
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0xAF
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0xD7
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0xFF
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x13B
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x163
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x18B
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x1C6
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x1EE
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x216
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x252
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x27A
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x2A2
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x2DE
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x306
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x32E
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x369
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x391
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x3B9
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x3F5
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x41D
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x445
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x481
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x4A9
ALSA /home/adrian/aica/aica/snd_card_aica.c:363: Value is 0x4D1


etc - cycling onwards to the end of the buffer and then repeating...



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
