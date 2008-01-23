From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Re: Problems with ALC882
Date: Wed, 23 Jan 2008 14:53:00 +0100
Message-ID: <b6251a620801230553g29a1a6c8s56ab59f6a7494875@mail.gmail.com>
References: <b6251a620801160920q327049ffifa72f77b17738f75@mail.gmail.com>
	<s5hzlv5r7yx.wl%tiwai@suse.de>
	<b6251a620801180810y6628debcxf9ff36de35514848@mail.gmail.com>
	<s5hve5rayvr.wl%tiwai@suse.de>
	<b6251a620801180850w492acd01v26a6648a710f5f0d@mail.gmail.com>
	<s5h8x2n3wbb.wl%tiwai@suse.de>
	<b6251a620801180911g40a5fe4cxa5ef72de9335e86d@mail.gmail.com>
	<s5h7ii73uv3.wl%tiwai@suse.de>
	<b6251a620801210327i78e66b15r813e9de83f142a57@mail.gmail.com>
	<s5hsl0re6xp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F48D10382A
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 14:53:01 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so4959439wag.8
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 05:53:00 -0800 (PST)
In-Reply-To: <s5hsl0re6xp.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(sorry for the delay)

2008/1/21, Takashi Iwai <tiwai@suse.de>:
> At Mon, 21 Jan 2008 12:27:18 +0100,
> Christophe Osuna wrote:
> > Now I need to check that I can open
> > the three at the same time but I am rather confident on this.
>
> Thanks.  Please let me know if it works.  Then I'll apply the patch to
> HG tree.

I have tested with three alsarecord reading from hw:0,0,0 hw:0,2,0 and
hw:0,2,1 and piping into aplay (on dmix) and it worked fine.

I think the patch can make its way to the HG tree.


> > Could you also tell me where I have to change code in order to force
> > the 8 kHz sampling rate? I will try to add an ugly change to
> > snd_hda_query_supported_pcm() but I am not sure on whether this is the
> > right place.
>
> You can override the info->streams[SNDRV_PCM_STREAM_CAPTURE].rates in
> alc_build_pcms().  It's zero as default, which means to probe the
> value from the codec.

I have tried to set info->streams[SNDDRV_PCM_STREAM_CAPTURE].rates to
SNDRV_PCM_RATE_8000 (and the same thing for playback) but "arecord |
aplay" at 8 kHz gave strange results. Well, I will try to investigate
more.
