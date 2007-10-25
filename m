From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Confused about 'default' device
Date: Thu, 25 Oct 2007 09:02:27 +0200
Message-ID: <1193295747.4869.1217732745@webmail.messagingengine.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
	<471F7479.9000602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3677924680
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Oct 2007 09:02:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <471F7479.9000602@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> >> Timur Tabi wrote:
> > Are there any definitions in ~/.asoundrc or /etc/asound.conf?  If not,
> > what driver is used, and does it have a file in /usr/share/alsa/cards/?
> 
> Ok, I made some progress.
> 
> According to http://alsa.opensrc.org/.asoundrc, because I'm using ALSA
> 1.0.8, I need to have an .asoundrc.

You'd need it to activate dmix, but sample rate/format conversion
already works with earlier versions.

>  So I added this .asoundrc:
> 
> pcm.!default {
> 	type hw
> 	card 0
> }

This disables all automatic conversions.

> And now sample rate conversion works!

Well, it always worked because mplayer does it itself.

Please try this:

    pcm.!default = "plughw:0"

And if this works, there is something wrong with you default device
definitions.  Please tell us the driver name and whether it has a file
in /usr/share/alsa/cards/.


Regards,
Clemens
