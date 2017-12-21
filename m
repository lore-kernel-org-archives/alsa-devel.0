From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 0/4] pcm: minor code cleanup
Date: Fri, 22 Dec 2017 08:25:42 +0900
Message-ID: <7514db92-4dc2-aeec-bcf5-1193f5342e94@sakamocchi.jp>
References: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
 <s5h1sjo9m16.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 024E7266D61
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 00:25:48 +0100 (CET)
In-Reply-To: <s5h1sjo9m16.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 21 2017 23:46, Takashi Iwai wrote:
> On Wed, 20 Dec 2017 18:16:59 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> When reviewing Maciej's patches[1], I found that alsa-lib includes some
>> unused codes in linear interpolation functionality. Furthermore, some code
>> comments includes 'copy & paste' mistakes.
>>
>> This patchset improves them.
>>
>> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-December/129370.html
>>
>> Takashi Sakamoto (4):
>>    pcm: remove unused macros of COPY_LABELS/COPY_END
>>    pcm: remove unused macros of GETU_LABELS/GETU_END
>>    pcm: remove unused macros of NORMS_LABELS/NORMS_END
>>    pcm: fix wrong comments for some cases of linear interpolation of PCM
>>      samples
> 
> All patches seem missing your sign-off.
> It's not mandatory for alsa-lib, but preferable.  Would you like me
> adding them manually?

Oops... Yes, please.
(I should have a script to check it before posting...)


Thanks

Takashi Sakamoto
