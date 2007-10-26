From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Confused about 'default' device
Date: Fri, 26 Oct 2007 08:45:35 +0200
Message-ID: <1193381135.13474.1217931843@webmail.messagingengine.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
	<471F7479.9000602@freescale.com>
	<1193295747.4869.1217732745@webmail.messagingengine.com>
	<4720A53E.5010801@freescale.com>
	<1193324526.17328.1217803511@webmail.messagingengine.com>
	<4720B039.9000909@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 12AC52449A
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 08:45:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4720B039.9000909@freescale.com>
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
> > mplayer disables ALSA's sample rate conversion and always uses its own.
> 
> I don't think that's true.

It's true if you use alsa-lib 1.0.9 or later.

> If it always uses its own, then how much it works on some video files
> and not others, and how come including a .asoundrc changes the
> behavior of mplayer?

mplayer relies on ALSA to do sample _format_ conversion.


Regards,
Clemens
