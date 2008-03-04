From: Rene Dohmen <acidjunk@gmail.com>
Subject: Re: no front speaker sound with ALC262
Date: Tue, 4 Mar 2008 14:37:39 +0100
Message-ID: <F7C8EBEB-D77A-43A9-8C96-58D9C4B047E0@gmail.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
	<47BF84BF.702@versatile.com> <47BF8500.1050802@versatile.com>
	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>
	<s5h1w6zvrz4.wl%tiwai@suse.de>
	<E0172064-A6C6-4874-81A2-B275A0954BD4@gmail.com>
	<165af2360802261519y6cdf878avf0af06c7b08db2a9@mail.gmail.com>
	<s5hfxveu1cf.wl%tiwai@suse.de>
	<165af2360802271016u211854b7yb5158f2dd3e718a@mail.gmail.com>
	<s5hfxvds579.wl%tiwai@suse.de> <s5hejaxs4xa.wl%tiwai@suse.de>
	<01CED47B-533E-4913-BED5-4DD6E9E86414@gmail.com>
	<s5hprufpuok.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E733244A7
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 14:37:46 +0100 (CET)
In-Reply-To: <s5hprufpuok.wl%tiwai@suse.de>
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

Hi List,

I tried it with the NID's i think are connected to headphone and  
speaker but so far no luck.

I'll have more time next friday but i was just wondering:
Is there a way to be 100% sure that this model is a new, not  
supported model yet?

Can you explain what numbers i can use instead of the 0x3060?

I am trying to get the datasheets of the soundsystem used, i think  
some custom board is used tot wire up the soundcard tot the internal  
speakers.

Thanks

Grz Rene


Op Feb 29, 2008, om 5:57 PM heeft Takashi Iwai het volgende geschreven:

> Instead, ALC262 (and other Realtek codecs) has a special sequence with
> coefficients to the vendor-defined widget.  Yes, it's a black magic.
>
> Try the following sequence:
>
> 	0x20 SET_COEF_INDEX 0x07
> 	0x20 SET_PROC_COEF 0x3060
>
> 0x3060 can be different numbers like 0x3070 or 0x3050.
> If you set a different number, reset the coef index again (i.e. always
> call as a pair).
