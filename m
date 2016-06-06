From: Alan Young <consult.awy@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Mon, 6 Jun 2016 10:42:41 +0100
Message-ID: <57554591.20103@gmail.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E31B926547F
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 11:42:42 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id k184so8592431wme.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2016 02:42:42 -0700 (PDT)
In-Reply-To: <s5hwpm2n2bq.wl-tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/06/16 09:34, Takashi Iwai wrote:
> On Sun, 05 Jun 2016 12:33:20 +0200,
> Alan Young wrote:
>> Regardless of what value of DMA_RESIDUE_GRANULARITY_xxx that a driver
>> claims to support, it is not really defined how fine a burst might
>> be. So the end result is, from the point of view of audio, that the
>> resulting position obtained by the pointer() call is pretty
>> inaccurate. Hence my proposal to attempt to improve the accuracy of
>> the pcm_status() result given the above constraints.
> Well, the subject appears misleading.  What you want isn't the audio
> timestamp accuracy.  From API POV, the accurate position is calculated
> via the (additional) delay.  So, what you want is rather the accurate
> position delay accounting, and the audio timestamp is merely one of
> the ways to achieve that.
>

Well, yes, you could put it that way. Whether an accurate delay, 
combined with the associated timestamp, or an accurate audio delay, I 
would have the data needed to track audio drift from wallclock time.

See my response to Raymond for more detail.

Alan.
