From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: switch over to new
 endpoint streaming logic
Date: Wed, 02 Nov 2011 17:18:20 +0100
Message-ID: <4EB16D4C.1080300@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>	<1320063030-3502-3-git-send-email-zonque@gmail.com>	<4EB05D3A.60405@ladisch.de>
	<s5hfwi64ith.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 321F0244AE
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 17:17:31 +0100 (CET)
In-Reply-To: <s5hfwi64ith.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxaudio@showlabor.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens, I thought you wanted to implement some framework for such
> devices?

Yes, but I haven't yet found time for an actual _implementation_.
I would be reusing most of the streaming code anyway, so it doesn't
hurt to implement implicit feedback first.


Regards,
Clemens
