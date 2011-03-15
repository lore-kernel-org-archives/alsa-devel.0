From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2 v2] ALSA: Add snd_ctl_update() to
 dynamically update a control
Date: Tue, 15 Mar 2011 15:17:58 +0100
Message-ID: <4D7F7516.7050009@ladisch.de>
References: <1300192269-20435-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 751CC244FB
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 15:16:20 +0100 (CET)
In-Reply-To: <1300192269-20435-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
> Add a function to dynamically update a given control.  If the
> control does not already exist, a third parameter is used to determine
> whether to actually add that control.  This is useful in cases where
> downloadable firmware at runtime can add or update existing controls.

> + * Updates the control instance created via snd_ctl_new() or
> + * snd_ctl_new1() of the given card.

This description was copied from snd_ctl_add(), and the "created ..."
part isn't really useful here.

It should be mentioned that the old control is destroyed, because some
drivers store volatile state in the control's private_data/_value, or
keep a pointer to the control('s ID) to be able to call snd_ctl_notify()
for it later.

> + * Returns zero if successful, or a negative error code on failure.
> + *

superfluous empty line

> +int snd_ctl_update(struct snd_card *card, struct snd_kcontrol *kcontrol,
> +		   int add_on_update)

add_on_update should be bool

> +	up_write(&card->controls_rwsem);
> +	ret = snd_ctl_add(card, kcontrol);

Doing this outside the semaphore doesn't look good.

I wonder whether snd_ctl_add() is the right function to use, because it
will assign a different numid event if the control didn't change.

> A separate patch needs to be made to make ALSA Mixer cope with this.

What happens?


Regards,
Clemens
