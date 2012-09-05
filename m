From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH 0/3] HDMI HBR(High Bit Rate) Feature bug
 fix for Intel's Chips
Date: Wed, 5 Sep 2012 14:34:35 +0800
Message-ID: <CA+v+29hkd=WA2=EB-==33+rW1-baGRXM=bbpCTJGX2EDgkY3eQ@mail.gmail.com>
References: <1346824718-18448-1-git-send-email-xingchao.wang@intel.com>
 <s5hk3w9j816.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 017812652E8
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 08:34:55 +0200 (CEST)
Received: by qafi29 with SMTP id i29so3917128qaf.17
 for <alsa-devel@alsa-project.org>; Tue, 04 Sep 2012 23:34:55 -0700 (PDT)
In-Reply-To: <s5hk3w9j816.wl%tiwai@suse.de>
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
Cc: anssi.hannula@iki.fi, alsa-devel@alsa-project.org, alanwww1@xbmc.org, fengguang.wu@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

2012/9/5 Takashi Iwai <tiwai@suse.de>:
> At Wed,  5 Sep 2012 13:58:35 +0800,
> Wang Xingchao wrote:
>>
>> Please Note This patchset has not been tested yet on any Hardware platform.
>> i could only confirm there's no compile error. :)
>> I test previous single patch on the Yamaha A/V receiver which works well, the
>> test results was also confirmed by some guys from XBMC forum.
>>
>> The idea of this patch comes from Anssi, Big credit to him at first!
>>
>> Any comments are appreciated!
>>
>> Changelog:
>> * do not touch channel_allocation priority order, use new api to get
>> correct channels number
>> * use spdif->status to check audio type, pcm or non-pcm
>> * create new non_pcm_mapping[] for non_pcm audio in seperate block
>> * add non_pcm hdmi_spec_per_cvt to remember previous audio type, used to
>>   determine whether need a channel mapping update during the pcm/non-pcm
>>   stream switch with same channel number.
>>
>>
>> Wang Xingchao (3):
>>   ALSA: hdmi - fix channel_allocation array wrong order
>>   ALSA: HDMI - Enable HBR feature on Intel chips
>>   ALSA: HDMI - Setup channel mapping for non_pcm audio
>
> The patches look good to me.  Maybe you can unify the subject line
> prefix (either lower or upper case), though :)
>

Okay. And I will let you know after the patches are tested, this may
take some time. :(

thanks
--xingchao

>
> thanks,
>
> Takashi
>
>>
>>  sound/pci/hda/patch_hdmi.c |   56 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 51 insertions(+), 5 deletions(-)
>>
>> --
>> 1.7.9.5
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
