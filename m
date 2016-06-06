From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Improving status timestamp accuracy
Date: Mon, 6 Jun 2016 09:53:58 -0500
Message-ID: <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D94C265795
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 16:54:00 +0200 (CEST)
In-Reply-To: <57554591.20103@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <consult.awy@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/6/16 4:42 AM, Alan Young wrote:
> On 06/06/16 09:34, Takashi Iwai wrote:
>> On Sun, 05 Jun 2016 12:33:20 +0200,
>> Alan Young wrote:
>>> Regardless of what value of DMA_RESIDUE_GRANULARITY_xxx that a driver
>>> claims to support, it is not really defined how fine a burst might
>>> be. So the end result is, from the point of view of audio, that the
>>> resulting position obtained by the pointer() call is pretty
>>> inaccurate. Hence my proposal to attempt to improve the accuracy of
>>> the pcm_status() result given the above constraints.
>> Well, the subject appears misleading.  What you want isn't the audio
>> timestamp accuracy.  From API POV, the accurate position is calculated
>> via the (additional) delay.  So, what you want is rather the accurate
>> position delay accounting, and the audio timestamp is merely one of
>> the ways to achieve that.
>>
>
> Well, yes, you could put it that way. Whether an accurate delay,
> combined with the associated timestamp, or an accurate audio delay, I
> would have the data needed to track audio drift from wallclock time.

I probably need more coffee but how is this patch helping track audio v. 
wallclock drift? The additional precision is based on wallclock deltas...

>
> See my response to Raymond for more detail.
>
> Alan.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
