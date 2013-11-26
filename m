From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-Audio: Is it okay to delay resuming codecs when
 resuming from S3?
Date: Tue, 26 Nov 2013 12:16:47 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141AF13@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F801419994@SHSMSX101.ccr.corp.intel.com>
 <s5hbo17y69q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EF0AA2607D7
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 13:16:59 +0100 (CET)
In-Reply-To: <s5hbo17y69q.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, November 26, 2013 3:25 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: HD-Audio: Is it okay to delay resuming codecs when resuming
> from S3?
> 
> At Tue, 26 Nov 2013 07:16:59 +0000,
> Lin, Mengdong wrote:
> >
> > Hi Takashi,
> >
> > Is it okay to delay resuming codecs when resuming from S3? i.e. skip
> snd_hda_resume() in azx_resume()?
> >
> > This would reduce driver resume time from S3. And the codecs will be
> resumed when being used for the 1st time after S3.
> >
> > Resuming a codec may cost more than 100ms. So even if we parallel
> resuming codecs in snd_hda_resume(), driver resume time on some
> platforms is still a bit long.
> 
> This causes problems on some hardware, e.g. inconsistent mute LEDs.
> So you cannot do it unconditionally.  We did it in the past, but had to
> switch the forced resume later.

Thanks for the info!
Are these problems caused by inconsistency between system assumption after S3 and audio codec HW status in D3?

Why the mute LED can be inconsistent?
Is the LED controlled by audio codec HW? If yes, the LED status when codec in D3 can be inconsistent from mute status before S3. 
But if the LED is controlled by software, there seems no inconsistency.

> Maybe we can add a flag indicating that the codec resume may be delayed.
> Then the bus resume checks the flags and skips the codec resume if it's
> set.

Okay. 
And is it okay to parallel resuming multiple codecs, also using the bus work queue to parallel suspending codecs?

Regards
Mengdong
