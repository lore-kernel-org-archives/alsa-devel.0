From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] usb-us122l: add support for compatible
	ioctl
Date: Thu, 28 Jul 2016 00:14:13 +0900
Message-ID: <6b5b74c2-7536-8bcb-e2f5-cd1ef9f55ec9@sakamocchi.jp>
References: <1469632008-29710-1-git-send-email-o-takashi@sakamocchi.jp>
 <1469632008-29710-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5h60rr15ku.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0F3DE267362
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 17:14:22 +0200 (CEST)
In-Reply-To: <s5h60rr15ku.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Jul 28 2016 00:08, Takashi Iwai wrote:
> On Wed, 27 Jul 2016 17:06:47 +0200,
> Takashi Sakamoto wrote:
>>
>> +#ifdef CONFIG_COMPAT
>> +static int usb_stream_hwdep_compat_ioctl(struct snd_hwdep *hw,
>> +					 struct file *file,
>> +					 unsigned int cmd, unsigned long arg)
>> +{
>> +	return usb_stream_hwdep_compat_ioctl(hw, file, cmd,
>> +					     (unsigned long)compat_ptr(arg));
> 
> Won't this go into the endless recursion?

Oh, indeed. I did just copy-and-paste here... I'll post revised version,
later.


Thanks

Takashi Sakamoto
