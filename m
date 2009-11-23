From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Xonar Essence ST (PCI) on
 2.6.32-rc8-00011-ga8a8a66: no analog audio, SPDIF fine
Date: Mon, 23 Nov 2009 10:18:29 +0100
Message-ID: <4B0A5365.1070106@ladisch.de>
References: <1258916033.3113.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 9721C245B4
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 10:18:33 +0100 (CET)
In-Reply-To: <1258916033.3113.8.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@linx.net>
Cc: ALSA developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Tony Vroon wrote:
> After the success of the Xonar D2X in my system, I decided to upgrade to
> an Essence ST (of the PCI variety, no D6 daughterboard). Unfortunately
> it seems that it produces no audio for me over the headphone port (the
> reason I bought this card) or the front-panel headphone port.
> 
> # cat /proc/asound/ST/cmi8788 
> 60: 19 01 00 09 19 01 00 09 00 00 00 00 00 00 00 00
            ^^^^^
The first ST driver did not work.  This will be fixed in ALSA 1.0.22
or in the 2.6.33 kernel; try the daily snapshot:
http://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/

> I'm wondering if the Essence ST driver was written based on an a ST+D6
> engineering sample as mine is the ST (no D6) retail box. Is it possible
> that the hardware is different?

The base board of the ST and ST+H6 are identical.  However, I wrote the
driver without any hardware at all, so I overlooked the CS2000 chip
which needs to be initialized.


HTH
Clemens
