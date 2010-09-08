From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch] ALSA: rawmidi: cleanup the get next midi
	device ioctl
Date: Wed, 08 Sep 2010 11:40:16 +0200
Message-ID: <4C875A00.7030005@ladisch.de>
References: <20100908085308.GC32047@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D249F24441
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 11:39:50 +0200 (CEST)
In-Reply-To: <20100908085308.GC32047@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Ulrich Drepper <drepper@redhat.com>
List-Id: alsa-devel@alsa-project.org

Dan Carpenter wrote:
> I'm doing an audit to find integer overflows and my static checker
> complained that in the original code "device + 1" could overflow.  The
> overflow is harmless, but it's still worth cleaning up.  The other thing
> that I noticed is that if you pass in a device which is higher than
> SNDRV_RAWMIDI_DEVICES then it doesn't return an error code but just
> tells you that the next device is "device + 1".
> 
> I have rewritten it to just return -EINVAL if you pass in a bogus value
> that's either too high or too low.

A negative value is a valid input.

> +		if (device > SNDRV_RAWMIDI_DEVICES)
> +			return -EINVAL;

		if (device >= SNDRV_RAWMIDI_DEVICES)


Regards,
Clemens
