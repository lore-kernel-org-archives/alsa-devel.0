From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: A need for support for SPI interfacing in alsa.
Date: Mon, 4 Oct 2004 08:54:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410040848500.2446@pnote.perex-int.cz>
References: <415EF5B2.6050106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C230529E
	for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2004 09:04:38 +0200 (MEST)
In-Reply-To: <415EF5B2.6050106@superbug.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2 Oct 2004, James Courtier-Dutton wrote:

> Does anyone know how we might support SPI interfaces? I don't know much 
> about them, and there is only one 32bit register and one interrupt pin 
> on the P17 chip to control this.

SPI interface means only serial communication between chips. It does not 
define the chip's registers etc. I suggest to create a library for SPI 
codecs in i2c/other (see i2c/other/ak4117.c for example).

Basically, from the driver view, you can directly control the wires or you 
might only ask to read / write some register and the master chip will do 
rest (like all AC97 bridges do). So, it depends on hardware - no common 
way.

Also, we should move other WM drivers from ice1712 directory to i2c/other 
as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
