From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
Date: Sun, 15 May 2016 23:29:27 +0200
Message-ID: <87mvnrhux4.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <s5hk2j38tmf.wl-tiwai@suse.de> <87twi1hssl.fsf@belgarion.home>
 <s5hy47c7jvd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C2CE261600
 for <alsa-devel@alsa-project.org>; Sun, 15 May 2016 23:29:33 +0200 (CEST)
In-Reply-To: <s5hy47c7jvd.wl-tiwai@suse.de> (Takashi Iwai's message of "Sat,
 14 May 2016 17:13:42 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> On Sat, 14 May 2016 11:50:50 +0200,
> Robert Jarzmik wrote:
>> >> +unsigned int ac97_bus_scan_one(struct ac97_controller *ac97,
>> >> +				      int codec_num)
>> >> +{
>> >> +	struct ac97_codec_device codec;
>> >> +	unsigned short vid1, vid2;
>> >> +	int ret;
>> >> +
>> >> +	codec.dev = *ac97->dev;
>> >> +	codec.num = codec_num;
>> >> +	ret = ac97->ops->read(&codec, AC97_VENDOR_ID1);
>> >> +	vid1 = (ret & 0xffff);
>> >> +	if (ret < 0)
>> >> +		return 0;
>> >
>> > Hmm.  This looks pretty hackish and dangerous.
>> You mean returning 0 even if the read failed, right ?
>
> No, my concern is that it's creating a dummy codec object temporarily
> on the stack just by copying some fields and calling the ops with it.
> (And actually the current code may work wrongly because lack of
>  zero-clear of the object.)
Ah yes, I remember now, the on-stack generated device, indeed ugly.

> IMO, a cleaner way would be to define the ops passed with both
> controller and codec objects as arguments, and pass NULL codec here.
It's rather unusual to need both the device and its controller in bus
operations. I must admit I have no better idea so far, so I'll try that just to
see how it looks like, and let's see next ...

Cheers.

-- 
Robert
