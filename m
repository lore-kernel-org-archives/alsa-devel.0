From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: Accessing alsa device in kernel space.
Date: Mon, 6 Aug 2007 22:29:46 +0300
Message-ID: <200708062229.46691.anarsoul@gmail.com>
References: <200708051911.23667.anarsoul@gmail.com>
	<s5hzm14d9k7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id BF50510381C
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 21:29:12 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so352546nfd
	for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2007 12:29:12 -0700 (PDT)
In-Reply-To: <s5hzm14d9k7.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6 August 2007 you wrote:
> At Sun, 5 Aug 2007 19:11:23 +0300,
>
> Vasily Khoruzhick wrote:
> > Hi, how to access to alsa device from kernel space?
> > I want to create driver for virtual soundcard, that will perform mixing
> > and rate converting in kernelspace, and put result in real hardware. But
> > I found no documentation how to open alsa device in kernel space :(
>
> You shouldn't do it.  It'd be horribly messy.
> If you'd like to access the device files of other hardwares, simply
> use the user-space solution.
>
>
> Takashi

Btw, why there's oss-emulation in kernel? AFAIK it can't use pcm-plugins (e.g. 
dmix), so oss-applications that try to play through /dev/dsp can't produce 
any sound, or they block soundcard and other programs can't use it.
