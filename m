From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Confused about 'default' device
Date: Wed, 24 Oct 2007 13:37:18 +0200
Message-ID: <1193225838.26984.1217558213@webmail.messagingengine.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1331F243F8
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 13:37:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4pggevv8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Timur Tabi wrote:
> > I'm having a hard time understand when ALSA does sample rate and format 
> > conversion, and when it doesn't.
> > 
> > When I issue the following command:
> > 
> > 	mplayer -ao alsa filename.mov -v
> > 
> > I get this output:
> > ...
> > alsa-init: using device default
> > alsa-init: format s24le are not supported by hardware
> > 
> > I was under the impression that ALSA can do format and sample rate conversion if 
> > necessary, but I guess that's not always the case.
> 
> It does.  mplayer seems to try first the hardware device without
> conversion and falls back to "default" PCM.

In this case, it uses only the "default" PCM device.  There seems to be
some problem with its definition.

Are there any definitions in ~/.asoundrc or /etc/asound.conf?  If not,
what driver is used, and does it have a file in /usr/share/alsa/cards/?


Regards,
Clemens
