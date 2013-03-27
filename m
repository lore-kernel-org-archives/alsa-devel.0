From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v5] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Wed, 27 Mar 2013 11:09:01 +0100
Message-ID: <5152C53D.5060604@ladisch.de>
References: <20130326211004.GD18838@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4620126506D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 11:09:04 +0100 (CET)
In-Reply-To: <20130326211004.GD18838@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Torstein Hegge wrote:
> The C-Media CM6631 USB receiver doesn't respond to changes in sample rate
> while the interface is active. The same behavior is observed in other UAC2
> hardware like the VIA VT1731.

Might it be possible that these devices have reset the interface (see
UAC2 section 3.16.3), and that the driver hasn't noticed this because it
doesn't handle Active Alternate Setting Control interrupts?


Regards,
Clemens
