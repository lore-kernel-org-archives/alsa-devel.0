From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 8/8] ALSA: control: arrange snd_ctl_new()
	as a local function
Date: Thu, 12 Feb 2015 21:45:24 +0900
Message-ID: <54DCA064.2050105@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>	<1423651052-19593-9-git-send-email-o-takashi@sakamocchi.jp>	<54DB4FD9.30608@metafoo.de>
 <s5hzj8koazb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 862A12604E3
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 13:45:28 +0100 (CET)
In-Reply-To: <s5hzj8koazb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Feb 11 2015 22:04, Takashi Iwai wrote:
> At Wed, 11 Feb 2015 13:49:29 +0100,
> Lars-Peter Clausen wrote:
>>
>> On 02/11/2015 11:37 AM, Takashi Sakamoto wrote:
>> [...]
>>> -/**
>>> - * snd_ctl_new - create a control instance from the template
>>> - * @control: the control template
>>> - * @access: the default control access
>>> - *
>>> - * Allocates a new struct snd_kcontrol instance and copies the given template
>>> - * to the new instance. It does not copy volatile data (access).
>>> - *
>>> - * Return: The pointer of the new instance, or %NULL on failure.
>>> - */
>>> -static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
>>> -					unsigned int access)
>>> +static struct snd_kcontrol *ctl_new(struct snd_kcontrol *control,
>>
>> I'd prefer to keep both the documentation as well as the 'snd_' prefix. 
>> Maybe just replace the '/**' with '/*' to prevent it from appearing in the 
>> public API documentation.
> 
> Yes, agreed.  There is no strict rule about snd_ prefix for
> non-exported objects.  We prefer not having snd_ prefix for local
> stuff in general just for readability.  But in this case, it doesn't
> improve so much.

Hm. I don't disagree with remaining these comments.

...But I have another issue. In my final patch in another series, I
change this function drastically. Then, should I spend a bit time to
revise them even if this is just a local function?
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087796.html


Thanks

Takashi Sakamoto
