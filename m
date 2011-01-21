From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Fri, 21 Jan 2011 14:25:49 +0800
Message-ID: <AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id E766F244F8
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 07:25:53 +0100 (CET)
Received: by ewy19 with SMTP id 19so699963ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 22:25:53 -0800 (PST)
In-Reply-To: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/19 Robin Neatherway <neatherway@gmail.com>

> I posted regarding this issue to alsa-users, but haven't had any response.
> I've come to the conclusion that I will have to modify the driver myself to
> rectify this problem, so I would appreciate some pointers as to how to get
> started with that.
>
> Running Xubuntu 10.10 with Alsa 1.0.23
>
> The sound chip is Intel HDA, ALC260. I have tried setting
>
> options snd-hda-intel model=fujitsu
>

> in /etc/modprobe.d/alsa-base.conf, but this hasn't made any difference.
> There is no "Jack Sense" option in alsamixer. I've also tried a couple of
> values for fix_position.
>

If you compiled the driver in debug mode, you can select model=test for
alc260

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=7cf51e48315d87b4c1cf600d611894f45f661142
