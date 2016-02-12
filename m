From: Jacobson <a_jacobson_1991@hotmail.com>
Subject: Re: Usb audio - unsuported sampling rates
Date: Fri, 12 Feb 2016 13:59:15 +0000 (UTC)
Message-ID: <loom.20160212T144852-896@post.gmane.org>
References: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
 <4FFBD182.9040503@gmail.com>
 <CADPOxSis1apDxiFn6A6g-Rdi22sOgeMqCe+vOsDXy3odvjALAg@mail.gmail.com>
 <4FFC9F8E.6090004@gmail.com> <4FFE8062.5040101@gmail.com>
 <CADPOxSi7ijOCobfyRVoTBPenY-gJBnPivaJF1pY8jnrgVgmxsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 24B0A2604A3
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 15:05:11 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1aUELK-00074U-9c
 for alsa-devel@alsa-project.org; Fri, 12 Feb 2016 15:05:07 +0100
Received: from CPE-123-211-93-31.lnse4.cha.bigpond.net.au ([123.211.93.31])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 15:05:06 +0100
Received: from a_jacobson_1991 by CPE-123-211-93-31.lnse4.cha.bigpond.net.au
 with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 15:05:06 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Gordon Dilan <gordon.dilan <at> gmail.com> writes:

> 
> Hello Daniel,
> 
> Thank you very much for your help and sorry for the late answer. I was
> without internet access for the last few days.
> 
> I have tried the patch that you sent me(with a minor modification:
> fp->rate_max(instead of min) = 48000; ).
> If I try to record using 48kHz and then playback, it will playback in 
"fast
> speed", voices being recorded as "chipmunks".
> Only at 16000Hz it records at "normal speed".
> 


Hi Daniel and Gordon, 

Sorry for posting on such an old thread. I have recently started using the 
PlayStation Eye for audio processing and I have run into the same issue of 
ALSA only allowing the device to capture at 16khz sampling rate when it 
should be capable of 48khz. Your last post indicates that even with a 
patch, the device only sampled at 16khz and just played the samples faster. 
I am just wondering if either of you came up with a solution to this 
problem? Was it ever possible to record at a 48khz?

Any help or information would be greatly appreciated. 

Thanks,

Jacobson. 
