From: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about 'default' device
Date: Thu, 25 Oct 2007 09:16:30 -0500
Message-ID: <4720A53E.5010801@freescale.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
	<471F7479.9000602@freescale.com>
	<1193295747.4869.1217732745@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F6B22454E
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Oct 2007 16:16:38 +0200 (CEST)
In-Reply-To: <1193295747.4869.1217732745@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> Well, it always worked because mplayer does it itself.

I'm confused.  Are you saying the addition of .asoundrc somehow forces mplayer 
to do sample-rate conversion where before it didn't because it assumed that Alsa 
would do it?

> Please try this:
> 
>     pcm.!default = "plughw:0"
> 
> And if this works, there is something wrong with you default device
> definitions.  Please tell us the driver name and whether it has a file
> in /usr/share/alsa/cards/.

I definitely did not add anything to /usr/share/alsa/cards for my audio driver.
