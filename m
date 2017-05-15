From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RFC 00/21] ALSA: pcm: add tracepoints for
 PCM params operation
Date: Mon, 15 May 2017 23:29:47 +0900
Message-ID: <bba04aee-5a88-ca35-3a05-41b23c738604@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
 <s5hvap2bjeh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 8DDA8267449
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 16:29:51 +0200 (CEST)
In-Reply-To: <s5hvap2bjeh.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On May 15 2017 17:42, Takashi Iwai wrote:
> On Sun, 14 May 2017 10:57:35 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> In the last Audio Mini Conference held with Linux Plumber conference 2016[1], I mentioned about tracepoints for PCM params operation. This patchset is for the idea.
>>
>> In ALSA PCM interface, applications can get hardware capability by ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCT_HW_PARAMS in a shape of 'struct snd_pcm_hw_params'. In kernel side, relevant processing is somewhat complicated and developers sometimes have hard time to debug drivers for PCM constraints and rules.
>>
>> This patchset adds tracepoints for hw_params operations. When CONFIG_SND_DEBUG is enabled, you can see 'trace_hw_params_mask/trace_hw_params_interval' events of 'snd_pcm' subsystem. When applications execute ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCTL_HW_PARAMS, these events are probed. Developers can get how many PCM rules are added into runtime of PCM substream and which rule changed which parameters.
>>
>> This patchset also includes some improvements. The last three commits brings small changes to kernel/userspace interface for error handling.
>>
>> I'm happy to receive your comment for this patchset. For your information, low level application of SNDRV_PCM_IOCTL_HW_REFINE operation is available in my github repository[2].
>
> The patches look good through a quick glance.
> The only concern I have is the function regression, since there are
> lots of code rewrites.  How did you test?

Currently, I did four things:

1. understand logic to process parameters, constraints and rules
2. add the tracepoints as early as the patchset
3. confirm that probed events include the same data commit by commit
4. do the above with refine-pcm-params.c and got valid results

For the above, I use ALSA Fireweorks/OXFW driver and supported devices, 
which I know correct behaviour.


Thanks

Takashi Sakamoto
