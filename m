From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Mon, 18 Mar 2013 10:15:44 +0100
Message-ID: <5146DB40.2060000@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id F20BD265255
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 10:15:47 +0100 (CET)
Received: by mail-wi0-f173.google.com with SMTP id hq4so2354841wib.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 02:15:47 -0700 (PDT)
In-Reply-To: <s5hehfduld0.wl%tiwai@suse.de>
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
Cc: ray@auraliti.com, andreas@akdesigninc.com, alsa-devel@alsa-project.org, clemens@ladisch.de, demian@auraliti.com
List-Id: alsa-devel@alsa-project.org

On 18.03.2013 10:07, Takashi Iwai wrote:
> At Sun, 17 Mar 2013 20:07:23 +0800,
> Daniel Mack wrote:
>>
>> Thanks to Andreas, I got my hands on a Playback Design MPD-3 and hacked
>> up some small hanges necessary to make it fully work with snd-usb.
>>
>> The device reports 0x80000000 in the bmFormats field of two of three of
>> its alternate settings, which wrongly made the driver believe it's a
>> usual PCM endpoint (actually due to a fix-up fallback). However, bit 31
>> of this mask in fact denotes 'raw data'.
>>
>> The effect of this issue is that in addition to the first altsetting with
>> a bit depth of 24, the driver exposed 8-bit and 16-bit native audio
>> formats on the raw data endpoints, which do not work as expected.
>>
>> Also, those devices need a 50ms delay after switching the USB interface.
> 
> Thanks, applied to for-next branch.
> 
> The remaining question is which PCM format is suitable for the raw
> data.  SND_PCM_FORMAT_SPECIAL should be OK, it won't regress at least,
> as no apps support this format.

Yes, I  thought about that for a while as well. In fact, the data format
the device supports on these altsettings is "DSD", but that doesn't have
a defined value in the UAC2 spec (and strictly speaking, DSD is not even
PCM).

So when a device is as unspecific as 'raw data', there's not much we can
do about that except for exposing the same level of uncertainty down to
the apps, right?


Thanks,
Daniel
