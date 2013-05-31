From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: regression: from 3.8 to 3.9: headphones output no
 sound on Intel HDA, codec VIA VT1802
Date: Fri, 31 May 2013 21:36:45 +0200
Message-ID: <CALxABCZVDrLMH+Y=b6CP8rehM5q7vikjoGNgi=S5jHKZuSSGsw@mail.gmail.com>
References: <CALxABCbP9hkNQ=xTEUMWb+6UhmVs2N-5kauYJe7d=j1z_RL+LA@mail.gmail.com>
 <s5h8v3irjeb.wl%tiwai@suse.de> <s5hy5biq3kr.wl%tiwai@suse.de>
 <CALxABCbyALmAKwCC6wNOgQWs8jD2X72aH8_++OW6R7m7C3vgfw@mail.gmail.com>
 <s5hr4haw190.wl%tiwai@suse.de> <s5hd2stq152.wl%tiwai@suse.de>
 <CALxABCaxJkG486g2reFDJD_nKzyaZkJnsRrwaLFNC9eFZBcXTg@mail.gmail.com>
 <s5ha9nwx1j3.wl%tiwai@suse.de>
 <CALxABCZMyqh5SSo=RpQCJNUR_p9yrG5x9DimFpzvgkCFLr4eug@mail.gmail.com>
 <s5h1u97jik9.wl%tiwai@suse.de>
 <CALxABCa27gVVJGWM-crvFOPmJXdZ0FEBc3=dPZ0pG+AhDB78cA@mail.gmail.com>
 <s5hk3myuoq6.wl%tiwai@suse.de>
 <CALxABCZHwKPDKPsjWJmK=-QzcC3fs2bKqHU0SCUmdH7OqGDNdA@mail.gmail.com>
 <s5h1u8wtsk9.wl%tiwai@suse.de>
 <CALxABCZdm=qd1E63NeabcqmD0csnL1FcuUBCFTwa1yDOVRVXyg@mail.gmail.com>
 <s5h1u8w8f82.wl%tiwai@suse.de>
 <CALxABCbJ-4_UPNX5qNAOy-PdQ+tp+vVBDE535nLyfjgzDjjebQ@mail.gmail.com>
 <s5h1u8p7pxi.wl%tiwai@suse.de>
 <CALxABCbBYRJDsXMw0Y0BLs+RuXNMa_RMOAF5i4rmWDaYPa2H0Q@mail.gmail.com>
 <s5hehcn2tc3.wl%tiwai@suse.de>
 <CALxABCaQ_drc+jKP4wZ5S_5wZVcE7rVXW_LZdVJ8tqZUai-=UQ@mail.gmail.com>
 <s5hbo7rowq5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CE22265559
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 21:37:06 +0200 (CEST)
Received: by mail-ob0-f174.google.com with SMTP id wd20so3778524obb.5
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 12:37:05 -0700 (PDT)
In-Reply-To: <s5hbo7rowq5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 31, 2013 at 8:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 31 May 2013 17:32:16 +0200, Alex Riesen wrote:
>> On Fri, May 31, 2013 at 3:05 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > Below is a series of patches.  For simplicity, I just attach them, not
>> > inlining to the mail.  They should be applicable cleanly to 3.9.4 as
>> > well.  Let me know if this works.  If this still doesn't work, I need
>> > to rewrite the patch to correct the pin-ctl / EAPD of the headphone
>> > pin after changing the speaker pin.
>>
>> Still does not work. The results are for 3.9.4 + patches:
>>
>>   http://familie-riesen.de/~raa/public/test/dpc-automute-vol-pinctl.tar.bz2
>>
>
> Grrr, EAPD on 0x25 seems reset by EAPD on 0x24 being turned off.
> We need to apply the patch of the last week again in the end.
> The revised one is below.  Please apply it on the top of the previous
> three patches.

Nope. Logs:

  http://familie-riesen.de/~raa/public/test/keep_eapd_on.tar.bz2
