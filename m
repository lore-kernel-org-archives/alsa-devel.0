From: Andy <hornett83@yahoo.co.uk>
Subject: ALC262 - HDA-Intel
Date: Tue, 24 Jul 2007 11:08:29 +0100 (BST)
Message-ID: <20070724100829.46373.qmail@web27209.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web27209.mail.ukl.yahoo.com (web27209.mail.ukl.yahoo.com
	[217.146.182.99]) by alsa0.perex.cz (Postfix) with SMTP id 1E6CB2449F
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 12:08:30 +0200 (CEST)
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

I have a ALC262 hda-intel card which doesn't function
quite correctly. Details can be found at
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/110145

I got bored of waiting for it to be fixed, and had a
go myself. My knowledge of ALSA is very limited, but
nevertheless it was really simple to add my device ids
to the quirks list in the patch_realtek.c file - eg:

...
SND_PCI_QUIRK(0x104d, 0x900e, "Sony ASSAMD",
ALC262_SONY_ASSAMD),
SND_PCI_QUIRK(0x104d, 0x1f00, "Sony ASSAMD",
ALC262_SONY_ASSAMD),
/* My card... */
SND_PCI_QUIRK(0x104d, 0x820f, "Sony ASSAMD",
ALC262_SONY_ASSAMD),
...

I found by trial and error that ALC262_SONY_ASSAMD
almost works. Connecting headphones disables built-in
speakers and unplugging them re-enables them.

However, something does not get initialised until this
is done. That is, every bootup using
ALC262_SONY_ASSAMD, I must plug in and remove my
headphones before the device is initialised properly. 

Until this is done, I get no sound and the little GUI
mixer in XFCE doesn't show the list of supported
outputs on the device. 

I'm posting this to the devel list as I'm more
interested the code side of things rather than
actually having working sound :)

Thanks
Andy.


      ___________________________________________________________ 
Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for
your free account today http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html 
