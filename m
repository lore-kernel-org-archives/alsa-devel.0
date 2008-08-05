From: "Bankim Bhavsar" <bankim.bhavsar@gmail.com>
Subject: Re: dmix in a forked process
Date: Tue, 5 Aug 2008 08:19:11 -0700
Message-ID: <4eccebac0808050819m21ab0616n2484e57e57030b6e@mail.gmail.com>
References: <4eccebac0808012003j49ea4351pc34f3f1ed7690f15@mail.gmail.com>
	<4eccebac0808021945s66b362e3u51ecedea830a04e4@mail.gmail.com>
	<Pine.LNX.4.61.0808032036330.31850@tm8103-a.perex-int.cz>
	<4eccebac0808031347v26c5c430h2e66f0439e64fbdf@mail.gmail.com>
	<s5hr693ss8g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by alsa0.perex.cz (Postfix) with ESMTP id DBB1D245F5
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 17:19:12 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3541631wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 05 Aug 2008 08:19:11 -0700 (PDT)
In-Reply-To: <s5hr693ss8g.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the reply Takashi.
Comments inline.

>> >> I'm currently porting the sound code of our app from OSS to ALSA but
>> >> this problem is preventing me from doing so.
>> >> Is there any way to get around this problem?
>> >
>> > What's your problem with fork()?
>>
>> If our app is the first to start dmix then a copy of the process (app)
>> will remain till
>> the last application closes the shared device.
>
> Right.  At least, its resources remain.

Yes this a concern.


>> So our problem is not fork but fork without *exec*.
>
> And what is your problem more exactly?
>
> We may create a small binary to do exec for the dmix server if this
> really matters.

Yes this is something we are looking for and will be a great
enhancement in the future release of alsa-lib :)

>  Or, an easier fix is to use more recent kernels.
> Then there is no longer fork for dmix.

Agreed and thats why we were planning to use the ioctl to determine
the sound drv version but somehow ioctl returns failure and not
something we would want to rely on.
 ioctl(spcm->poll_fd, SNDRV_PCM_IOCTL_PVERSION, &ver);

Also our product VMware workstation is supported on wide range of
Linux operating systems and so we don't want to restrict with
snd drv version > 2.0.8

Thanks,
Bankim.
