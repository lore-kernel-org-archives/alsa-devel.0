From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/3] ALSA: usb: move ua101 driver
Date: Mon, 01 Mar 2010 12:27:31 +0100
Message-ID: <4B8BA4A3.1060506@ladisch.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D0B1C2414B
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 12:27:37 +0100 (CET)
In-Reply-To: <1267194883-6854-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> As part of the USB audio code cleanup, move the non-standard ua101
> driver out of the way.

A directory with a single source file in it isn't quite an improvement.
Please name it "misc" so that other specialized drivers could be put in
there.


Regards,
Clemens
