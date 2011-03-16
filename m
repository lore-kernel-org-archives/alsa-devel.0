From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2 v3] ALSA: Add snd_ctl_update() to
 dynamically update a control
Date: Wed, 16 Mar 2011 12:45:55 +0100
Message-ID: <4D80A2F3.9090303@ladisch.de>
References: <1300273135-17101-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C4C7C2412E
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 12:44:17 +0100 (CET)
In-Reply-To: <1300273135-17101-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> Any comments on whether it would be advisable to use the same `numid' when
> I update an existing control?

"Update" sounds like it would change some properties of the existing
control.  However, what this function does is to entirely replace the
old control(s) with new one(s) (and this is also how the userspace
notifications look), so I think assigning a new ID is appropriate here,
if you call it snd_ctl_replace().  :)


Regards,
Clemens
