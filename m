From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch v2] ALSA: rawmidi: fix the get next midi
	device ioctl
Date: Thu, 9 Sep 2010 10:46:05 +0200
Message-ID: <20100909084605.GB10250@bicker>
References: <20100908193641.GA3463@bicker> <4C889074.6060901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2D24F2414D
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 10:46:20 +0200 (CEST)
Received: by qwj9 with SMTP id 9so169837qwj.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Sep 2010 01:46:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C889074.6060901@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Ulrich Drepper <drepper@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 09, 2010 at 09:44:52AM +0200, Clemens Ladisch wrote:
> Dan Carpenter wrote:
> > If we pass in a device which is higher than SNDRV_RAWMIDI_DEVICES then
> > this function just returns device + 1 which isn't helpful.  I've
> > modified it to return -EINVAL instead.
> > 
> > Also Smatch complains because the "device + 1" could be an integer
> > overflow.  It's harmless,
> 
> It would result in device==INT_MIN, which would make the while loop go
> through 2^31 values before finding the first MIDI device.
> 

Oh crap.  You're right.  For some reason I got mixed up.

regards,
dan carpenter

> 
> Regards,
> Clemens
