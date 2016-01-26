From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [sound:for-next 5/5]
 sound/firewire/bebob/bebob_stream.c:57:3-14: code aligned with following
 code on line 58
Date: Tue, 26 Jan 2016 21:19:52 +0900
Message-ID: <56A76468.6000409@sakamocchi.jp>
References: <201601261604.CeDxAxPv%fengguang.wu@intel.com>
 <alpine.DEB.2.10.1601261134390.2503@hadrien> <s5hvb6g8vyr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0277F260412
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 13:19:57 +0100 (CET)
In-Reply-To: <s5hvb6g8vyr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Lucas Tanure <tanure@linux.com>
List-Id: alsa-devel@alsa-project.org

On Jan 26 2016 19:40, Takashi Iwai wrote:
> On Tue, 26 Jan 2016 11:35:25 +0100,
> Julia Lawall wrote:
>>
>> It looks like braces are missing here.
> 
> Indeed.  Corrected the patch now.  Thanks!
> 
> 
> Takashi
> 
>>
>> julia

Oh... Thanks for every persons to fix it.
(and I should have took enough rest...)

>> On Tue, 26 Jan 2016, kbuild test robot wrote:
>>
>>> CC: kbuild-all@01.org
>>> CC: alsa-devel@alsa-project.org
>>> TO: Lucas Tanure <tanure@linux.com>
>>> CC: Takashi Iwai <tiwai@suse.de>
>>> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
>>> head:   a1d35f23965e7c0175ddecb1af0ae287c4e0aa23
>>> commit: a1d35f23965e7c0175ddecb1af0ae287c4e0aa23 [5/5] ALSA: bebob: Use a signed return type for get_formation_index
>>> :::::: branch date: 3 hours ago
>>> :::::: commit date: 3 hours ago
>>>
>>>>> sound/firewire/bebob/bebob_stream.c:57:3-14: code aligned with following code on line 58
>>>
>>> git remote add sound https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>> git remote update sound
>>> git checkout a1d35f23965e7c0175ddecb1af0ae287c4e0aa23
>>> vim +57 sound/firewire/bebob/bebob_stream.c
>>>
>>> a1d35f23 Lucas Tanure     2016-01-25  51  get_formation_index(unsigned int rate, unsigned int *index)
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  52  {
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  53  	unsigned int i;
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  54
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  55  	for (i = 0; i < ARRAY_SIZE(snd_bebob_rate_table); i++) {
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  56  		if (snd_bebob_rate_table[i] == rate)
>>> a1d35f23 Lucas Tanure     2016-01-25 @57  			*index = i;
>>> a1d35f23 Lucas Tanure     2016-01-25 @58  			return 0;
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  59  	}
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  60  	return -EINVAL;
>>> eb7b3a05 Takashi Sakamoto 2014-04-25  61  }
