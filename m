From: "Rene Dohmen" <acidjunk@gmail.com>
Subject: Re: no front speaker sound with ALC262
Date: Wed, 27 Feb 2008 19:16:23 +0100
Message-ID: <165af2360802271016u211854b7yb5158f2dd3e718a@mail.gmail.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
	<47BF84BF.702@versatile.com> <47BF8500.1050802@versatile.com>
	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>
	<s5h1w6zvrz4.wl%tiwai@suse.de>
	<E0172064-A6C6-4874-81A2-B275A0954BD4@gmail.com>
	<165af2360802261519y6cdf878avf0af06c7b08db2a9@mail.gmail.com>
	<s5hfxveu1cf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 27554243BB
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 19:16:24 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so2036796fgb.44
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 10:16:23 -0800 (PST)
In-Reply-To: <s5hfxveu1cf.wl%tiwai@suse.de>
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

I tried it with all avalialable NIDS:

sudo ./hda-verb /dev/snd/hwC0D0  0x14 SET_EAPD 0x02
Is this correct?

And is it so with all module options?
>

Yes with all tested codecs: are there any more options that i can use?

Thanks,
 Rene
