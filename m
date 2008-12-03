From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: Re: question for the all-knowing - firewire audio
	hardware
Date: Wed, 3 Dec 2008 14:28:43 -0800 (PST)
Message-ID: <747517.674.qm@web65606.mail.ac4.yahoo.com>
References: <805474.11224.qm@web65609.mail.ac4.yahoo.com>
	<20081203182423.GA2459@localhost>
Reply-To: "S. Aguinaga" <sa_jr@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65606.mail.ac4.yahoo.com (web65606.mail.ac4.yahoo.com
	[76.13.9.74]) by alsa0.perex.cz (Postfix) with SMTP id 475FE10381E
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 23:28:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi John,

Thank you, I went to the site and downloaded everything (including the dependencies, to be able to build ffado) but ran into one problem: 
The README file says to launch the daemon, but it fails:

  jackd -v  -d firewire
getting driver descriptor from /usr/lib/jack/jack_alsa.so
getting driver descriptor from /usr/lib/jack/jack_dummy.so
getting driver descriptor from /usr/lib/jack/jack_freebob.so
getting driver descriptor from /usr/lib/jack/jack_oss.so
jackd: unknown driver 'firewire'
 
I realize this is loosely related to alsa-devel, but ...
Launching the qjackctl  raises other issues ... when I start it, it's stopped immediately due to:
 

cannot create /dev/shm/jack-1000 directory (Permission denied)
cannot create server sockets
cannot create engine

and noticed that the only options under "Interface" setup are:
hw:0, plughw:0,  /dev/dsp ... but all these correspond to the built-in HDA card and not my firewire.

only one device is register as a card:
cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x9b500000 irq 20
 
I do have a /dev/raw1394 ... but something is not configuring it as an audio device, right? 


// Sal


________________________________
From: John Rigng <?
aldev@sound-man.co.uk>
To: S. Aguinaga <sa_jr@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Wednesday, December 3, 2008 12:24:23 PM
Subject: Re: [alsa-devel] question for the all-knowing - firewire audio hardware

On Wed, Dec 03, 2008 at 09:43:56AM -0800, S. Aguinaga wrote:
> I have a couple of machines connected to FireWire Motu devices (running OS X).  We want to develop some new apps on linux and the only info I've found is: http://www.olafchrist.de/ieee1394/index.php, but its rather old and single device specific.
> 
> Are there any other solutions available? Or are there other devices (firewire) that are supported by the ALSA project?

Have you looked here?
http://www.ffado.org

John
