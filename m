From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch v2] ALSA: rawmidi: fix the get next midi
	device ioctl
Date: Thu, 09 Sep 2010 09:44:52 +0200
Message-ID: <4C889074.6060901@ladisch.de>
References: <20100908193641.GA3463@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A179824552
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 09:44:32 +0200 (CEST)
In-Reply-To: <20100908193641.GA3463@bicker>
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
> If we pass in a device which is higher than SNDRV_RAWMIDI_DEVICES then
> this function just returns device + 1 which isn't helpful.  I've
> modified it to return -EINVAL instead.
> 
> Also Smatch complains because the "device + 1" could be an integer
> overflow.  It's harmless,

It would result in device==INT_MIN, which would make the while loop go
through 2^31 values before finding the first MIDI device.


Regards,
Clemens
