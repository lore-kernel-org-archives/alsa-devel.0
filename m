From: anish singh <anish198519851985@gmail.com>
Subject: Re: Headset driver detection problem during bootup
Date: Sat, 20 Aug 2011 22:21:10 +0900
Message-ID: <CAK7N6vrYRbGD14CJn4iNavc8CL_N8e5zqFbpiZ1yzRi-7kdRqA@mail.gmail.com>
References: <CAK7N6vrj8V+7EYLmd92qd+Mae2KZu8K6BVwnwda=3y2vrcDWRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3D16E243DA
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 15:21:12 +0200 (CEST)
Received: by wyh22 with SMTP id 22so2787899wyh.38
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2011 06:21:10 -0700 (PDT)
In-Reply-To: <CAK7N6vrj8V+7EYLmd92qd+Mae2KZu8K6BVwnwda=3y2vrcDWRw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel-mail <linux-kernel@vger.kernel.org>, kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Takashi Iwai <tiwai@suse.de>, Vince Weaver <vweaver1@eecs.utk.edu>, "Edgar (gimli) Hucek" <gimli@dark-green.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

adding more information and experts on alsa.

On Fri, Aug 19, 2011 at 9:23 PM, anish singh
<anish198519851985@gmail.com> wrote:
> I need some suggestions for below situation:
>
> Headset if it is inserted before the device is powered up is
> now detected by forcefully calling the interrupt handler in
> the probe function of the headset driver.
Headset is detected in our andorid device by using a detect gpio
 which is turned on when headset is inserted.If the headset
 is inserted right from very beginging i.e. before device is even
 turned on then we forcefully call the handler and thereby in
 handler we check if gpio is turned on or not and do the rest
of things.

> Once the handler is called then we find out if the headset
> is there or not using gpio and then normal detection happens
>
> Is it the right way to detect the device during power-up?
Does not linux have any other way of doing this which i may
be missing? How this is handled in the case of ALSA jack i.e.
the jack drivers which is using alsa framework for detection?
Android doesn't use ALSA framework for reporting JACK.
>
> After the device is powered up and then if we insert headset
> then it is working fine by calling the interrupt handler and
> everything goes fine.
>
> linux -2.3.5
> Android Device
>
