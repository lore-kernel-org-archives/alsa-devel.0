From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Problems with maintaining a separate alsa-driver
 in a	distribution
Date: Mon, 18 May 2009 13:55:57 +0300
Message-ID: <4A113EBD.8050705@pardus.org.tr>
References: <4A113966.5070807@pardus.org.tr> <s5h7i0e8z4i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id DEFD610382E
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 12:56:08 +0200 (CEST)
In-Reply-To: <s5h7i0e8z4i.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>
> It's fairly difficult because the internal API was changed.
> Especially the core struct was modified recently, thus there is no
> ABI compatibility at all between the older kernel and the latest alsa
> driver.
>
>   
>> Is it technically possible to patch those tiny drivers onto
>> alsa-driver and compile them if the .config file from the kernel source
>> has enabled those DVB devices?
>>
>> Or maybe I should enable ALSA in-kernel, compile those DVB sound stuff
>> and remove the sound/ directory from the kernel package? (Even the idea
>> sounds really *dirty*, dunno if it's technically possible too)
>>     
>
> You'd need to copy the original ALSA in-kernel stuff, copy the headers
> from alsa-driver, then rebuild the related modules in kernel to follow
> the new API.  Also, some wrappers would be needed, e.g. for the
> obsoleted snd_card_new().
>   

But that shouldn't pose any problem if I stick with 2.6.30_rc* + latest
alsa-driver right? But yes, during the lifetime of a stable distribution
release, the separate alsa-driver will always move faster than the
kernel and the ABI changes will be inevitable.

So It will become difficult enough when the stock kernel of the distro
and alsa-driver diverges from each other, am I right?

Thanks,
