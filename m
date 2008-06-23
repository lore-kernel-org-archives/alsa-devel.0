From: =?iso-8859-1?q?C=E9dric_Br=E9gardis?= <cedric.bregardis@free.fr>
Subject: Re: Audiowerk2 driver doesnt check pci subsystem id.
Date: Mon, 23 Jun 2008 19:43:20 +0200
Message-ID: <200806231943.21376.cedric.bregardis@free.fr>
References: <200806231732.19461.mike@mtgambier.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 58AFC248EE
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 19:43:24 +0200 (CEST)
In-Reply-To: <200806231732.19461.mike@mtgambier.net>
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
To: Mike Lampard <mike@mtgambier.net>
Cc: Takashi Iwai <tiwai@suse.de>, jhassler@free.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

At Monday 23 June 2008 10:02:17, Mike Lampard wrote:
> Hi
>
> Is there any chance you could add a pci subsystem id check to your
> Audiowerk2 alsa driver?  As you know, at the moment it claims all saa7146
> devices as AW2's, which is a pain for me because I also have DVB hardware
> that uses the SAA7146..

Indeed, it is a problem. However, I am not sure that the subsystem id is 
working correctly for AW2. In any case the behavior on my system is strange. 
Here is the result of the command 'lspci -x'

[...]
02:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
00: 31 11 46 71 02 00 80 02 01 00 80 04 00 40 00 00
10: 00 bc af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
[...]

SAA7146 datasheet says that subsystem ID is at address 0x2C of configuration 
space regsiters, and:

"this value will be loaded after a PCI reset from external
hardware using the I2C-bus; the default value is 0000H"

So there is no specific subsystem id on my AW2: it is the default value.

I have noted that the card has an eeprom on i2c (reference 8585c) but it seams 
it doesn't help.

The solution could be to suppose that the AW2 subid is 0. But if another card 
has the same behavior, there will be a problem.

Mike, could you give us the result of 'lspci -x' command on your system 
please ?

And I rely upon the list to correct me if I made wrong assumption ;-).

Cedric.


>
> Cheers & Good Work,
>
> Mike
