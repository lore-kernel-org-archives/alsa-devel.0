From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] Headphones no longer working on
	MacPro6, 1 with 4.4
Date: Fri, 20 May 2016 15:27:22 -0700
Message-ID: <f64ce31c-4465-0f4a-b7f4-4546fe3bc66a@redhat.com>
References: <56E8611D.8090005@redhat.com> <s5h8u1jwmym.wl-tiwai@suse.de>
 <s5h60wnwmgt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id F10FB2606E3
 for <alsa-devel@alsa-project.org>; Sat, 21 May 2016 00:27:26 +0200 (CEST)
Received: by mail-qk0-f170.google.com with SMTP id x7so75437473qkd.3
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 15:27:26 -0700 (PDT)
In-Reply-To: <s5h60wnwmgt.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/15/2016 12:49 PM, Takashi Iwai wrote:
> On Tue, 15 Mar 2016 20:38:41 +0100,
> Takashi Iwai wrote:
>>
>> On Tue, 15 Mar 2016 20:23:09 +0100,
>> Laura Abbott wrote:
>>>
>>> Hi,
>>>
>>> We received a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1316119
>>> that the headphone jack on a MacPro6,1 stopped working on an upgrade from 4.3
>>> to 4.4.
>>>
>>> The bugzilla has the alsainfo, diffing shows that the Amp-Out vals are
>>> different. I tried a revert of 9f660a1c4 (" ALSA: hda/realtek - Fix silent
>>> headphone output on MacPro 4,1 (v2)") but that didn't help.
>>>
>>> Any ideas before asking for a bisect? Does this hardware version need to have
>>> the vref fixup as well?
>>
>> The obvious difference is the power state of each node.  The recent
>> kernel has the finer power saving mode, and this might be the cause --
>> Mac has some secret that requires some node to be powered up.
>>
>> Try to power on each node via hda-verb.  For example, to power up the
>> node 0x05, run like:
>>   hda-verb /dev/snd/hwC0D0 0x05 SET_POWER 0x01
>
> Oops, a typo: the last argument must be 0x00, corresponding to D0:
>     hda-verb /dev/snd/hwC0D0 0x05 SET_POWER 0x00
>
>

Bringing this back again, the command that makes it work is

hda-verb /dev/snd/hwC0D0 0x10 SET_POWER 0x00

And this is still needed as of 4.5.4

> Takashi
>

Thanks,
Laura
