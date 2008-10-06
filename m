From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: snd-usb-audio: support for Edirol
 UA-4FX device
Date: Mon, 06 Oct 2008 08:53:09 +0200
Message-ID: <48E9B5D5.9080404@ladisch.de>
References: <12231307783118-git-send-email-pedro.lopez.cabanillas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 9F14124373
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 08:53:03 +0200 (CEST)
In-Reply-To: <12231307783118-git-send-email-pedro.lopez.cabanillas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
> Renamed the old quirk function for ua-700/ua-25 to become more
> generic, moving the MIDI interfaces to the quirk data header.

The MIDI interfaces have to be detected dynamically because in the half-
duplex 96 kHz modes, they have a different interface number.


Regards,
Clemens
