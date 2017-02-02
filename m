From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [RFC] [ALSA][CONTROL] Added 2 ioctls for
 reading/writing values of multiple controls in one go (at once)
Date: Thu, 2 Feb 2017 18:22:43 +0100
Message-ID: <0cee3189-8090-b2dd-657a-cd1ac034a441@ladisch.de>
References: <CGME20170202031525epcas1p2164b4ca25afe9fb5cd418d004da961f5@epcas1p2.samsung.com>
 <1486005286-25625-1-git-send-email-satendra.t@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486005286-25625-1-git-send-email-satendra.t@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: alsa-devel@alsa-project.org, ycheon.song@samsung.com, tiwai@suse.com, linux-kernel@vger.kernel.org, nishant.s4@samsung.com, hemanshu.s@samsung.com, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

Satendra Singh Thakur wrote:
> -Added an ioctl to read values of multiple elements at once
> -Added an ioctl to write values of multiple elements at once
> -In the absence of above ioctls user needs to call N ioctls to
>  read/write value of N elements which requires N context switches

And why are these N context switches a problem?

> -Above mentioned ioctl will be useful for alsa utils such as amixer
>  which reads all controls of given sound card

Is there a noticeable difference?


Regards,
Clemens
