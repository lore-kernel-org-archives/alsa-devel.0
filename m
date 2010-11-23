From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa: support module on-demand loading for
 seq	and timer
Date: Tue, 23 Nov 2010 16:45:53 +0100
Message-ID: <4CEBE1B1.4070906@ladisch.de>
References: <1290508964.1164.3.camel@yio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C8898103A99
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 16:43:37 +0100 (CET)
In-Reply-To: <1290508964.1164.3.camel@yio>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

Kay Sievers wrote:
> If CONFIG_SND_DYNAMIC_MINORS is used, assign /dev/snd/seq and
> /dev/snd/timer the usual static minors, and export specific
> module aliases to generate udev module on-demand loading
> instructions: ...
> As soon as userspace accesses any of these nodes, the in-kernel
> module-loader will load the module, and the device can be used.

Is this another mechanism than sound/core/sound.c::autoload_device()?
Because in this case, that function can go away.

> +++ b/sound/core/seq/seq.c
> +MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_SEQUENCER);
> +MODULE_ALIAS("devname:snd/seq");

The device name that alsa-lib tries to use for autoloading is actually
/dev/aloadSEQ.

> This is part of systemd's effort to get rid of unconditional
> module load instructions and needless init scripts.

So you're going to add the entries for card driver autoloading
(/dev/aloadC*), too?


Regards,
Clemens
