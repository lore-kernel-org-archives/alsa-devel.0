From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: FIX: soundblaster rear channels (ens1371)
Date: Fri, 17 Jan 2003 11:36:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301171123.42602.pieter.palmers@student.kuleuven.ac.be>
References: <200301160014.11787.c.esken@cityweb.de> <200301170104.40726.pieter.palmers@student.kuleuven.ac.be> <s5hsmvs14oo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmvs14oo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> 
>> Finally I figured out how to enable the rear channel separately from the 
front 
>> on the creative labs CT5880 (= modified ens1371 as it seems).
 
>great!  thanks for your work!

no problem. 
Thank you guys for your work. Figuring this out took me half a day. I'm sure 
that you guys all spent more than that on this project. I'm happy to be able 
to help out. I wanted the rear channels to work, and so I tried it myself. 
Now everybody can benifit from this work. Isn't this the way open-source 
works? take a lot - give what you can

> Uros has been working on the ALSA SAM9407 driver, and IIRC, maxi ISIS
> uses a similar (same?) chip.  he might be able to help the development
> of this driver.
>
The ISIS uses the successor of the SAM9407, the SAM9707. Differences seem to 
be minor (only the fact that it supports 6 extra channels).

The problem is that it is an ISA chip, and they used a 'creative' way of 
building a PCI card with it: They built a card based on the ESS Maestro-2EM, 
which is an Maestro-2E with an additional 'modem dsp' port, i.e. an ISA port. 
They used this port to connect the SAM chip.

So actually it would be helpfull if I had someone with ESS Maestro experience. 
I'm wondering if it's possible to set up a DMA transfer to the modem port. 
The Maestro is (in my opinion) a pretty compicated device so I think it might 
be possible.
Any Maestro-connaiseurs on this list?

Pieter




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
