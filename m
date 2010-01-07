From: =?ISO-8859-1?Q?Christian_St=F6veken?= <christian.stoeveken@gmail.com>
Subject: VGN-P11Z_G (hda-intel ALC262) internal microphone not
	working
Date: Fri, 8 Jan 2010 00:34:49 +0100
Message-ID: <7c16f72a1001071534sd8992e9je69bab0271b491b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 0155B2439C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 00:34:49 +0100 (CET)
Received: by fxm4 with SMTP id 4so59415039fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2010 15:34:49 -0800 (PST)
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

I'm running Ubuntu Karmic on a Vaio P11z and wanted to ask if there's
anything I can do to help
get the not working microphone going for me and all P11z users ;-)

Manufacturer: Sony Corporation
Product Name: VGN-P11Z_G
Soundcards recognised by ALSA: HDA-Intel - HDA Intel MID
Codec: Realtek ALC262

I already upgraded to alsa 1.0.21 using that
http://www.webupd8.org/2009/11/ubuntu-karmic-upgrade-alsa-to-1021-from.htmlPPA
and am atm on 2.6.33-020633rc3-generic.

alsa-info:

->
http://www.alsa-project.org/db/?f=35205f955e08e7e16b5274862f6b376b890731e3

-> toshiba-s06 (somewhat working)
http://www.alsa-project.org/db/?f=8ae0ab7b6672e41550651dbda63587438c93756f
the issues:

   - Microphone isn't working
   with toshiba-s06 it is sometimes working right after powering up,
   sometimes I have to force-reload alsa.
   - Sound also comes from the speakers with plugged-in headphones
   sony-assamd / toshiba-s06 (and multiple others fix that issue)


Regards,
Chris
<http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>
