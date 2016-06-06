From: Alan Young <consult.awy@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Mon, 6 Jun 2016 10:40:32 +0100
Message-ID: <57554510.9070700@gmail.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com>
 <CAN8cciab89x5ZQaBkSAGxEOzQ7FB3ORJAcd47Gu6EjSVDmk2cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 01A6926547F
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 11:40:35 +0200 (CEST)
Received: by mail-lf0-f51.google.com with SMTP id w16so90695848lfd.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2016 02:40:34 -0700 (PDT)
In-Reply-To: <CAN8cciab89x5ZQaBkSAGxEOzQ7FB3ORJAcd47Gu6EjSVDmk2cA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/06/16 02:24, Raymond Yau wrote:
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=cf40ea169aad366b222283f431addafea6327149;hp=4bdb09126a32feb4394eaeb1d400d87e7c968770
>
> HDA has hardware specific feature (audio wallclock) for the timestamp 
> and period wakeup can be disabled
>
>
> only a few pci drivers which read the residue value from hardware 
> register (e.g. hda-intel, oxygen , .) you have to measure the 
> granularity since the unit may be different for usb, pcie and firewire 
> sound card
>

Thank you Raymond. Yes, (I think) I understand all that. Let me restate 
my understanding of the situation.

The pointer position will generally be inaccurate by up to a period 
size. Even when a driver claims to support 
DMA_RESIDUE_GRANULARITY_BURST, the reported data is still unlikely to be 
sample accurate (as the size of a burst is undefined). For most drivers 
the reported position will be inaccurate and the actual accuracy cannot 
be determined.

The delay is also likely to be inaccurate. It is intended that this 
could include things such as codec delay but for most drivers this is 
not included. A few drivers, and in particular USB via an estimate, do 
try to include the in-flight transfer delay. In some ways this is the 
worst case: the delay may or may not include the transfer delay AND may 
or may not include the codec delay; what it actually includes is unknown.

The result of these is that both the position and delay may be 
inaccurate and the degree to which this is the case is not known.

We can tell that the position has not changed since the last call to 
snd_pcm_update_hw_ptr0() because new_hw_ptr == old_hw_ptr. We can use 
this knowledge to adjust the audio_tstamp returned by the time elapsed 
since the previous call (for SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT). We 
can also make such an adjustment even if the position has changed to 
better deal with the inaccuracy of position reporting.

Because of the 2 different types of unknown accuracy in delay, we cannot 
do the same trick with this. In many ways being able to update the delay 
in this way would be ideal. If we could, then we could leave 
audio_tstamp alone and let audio_tstamp_config.report_delay determine if 
the adjusted delay is also included in that. Since, in practice, most 
drivers either contain no codec delay value of a constant one, we can 
still use such a mechanim for most practical cases.

Have I got anything wrong above?

I'm going to test a revised patch based on these assumptions.

>
> as the application is based on the pointer for read/write, you still 
> need to use small period size and CPU power if you want to determine 
> the value returned by snd_pcm_rewindable is safe or not

My point is that I want to find a way to get reported delay and/or audio 
timestamps that are more accurate that a period time even in the absence 
of hardware that has specific support for this.

Alan.
