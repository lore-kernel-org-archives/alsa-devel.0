From: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Subject: Re: Process of sumit the Audio driver code to ALSA
Date: Mon, 7 Mar 2011 03:26:26 -0800
Message-ID: <290463D19D2E064191F1F96ECA480A89432CB6D840@EXMAIL02.scwf.nsc.com>
References: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1295359939-14673-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hmxmygtre.wl%tiwai@suse.de>
	<290463D19D2E064191F1F96ECA480A89432873706D@EXMAIL02.scwf.nsc.com>
	<s5hwrm1l68q.wl%tiwai@suse.de>
	<290463D19D2E064191F1F96ECA480A8943287370CB@EXMAIL02.scwf.nsc.com>
	<s5htyh5l4zg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw03.nsc.com (mail6.nsc.com [12.24.21.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 00ED610380E
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:26:54 +0100 (CET)
Received: from SCNTRDCSS6.nsc.com (scntrdcss6.nsc.com [10.188.130.177])
	by sc-mailgw03.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	2E21D1C400B0
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 03:26:44 -0800 (PST)
In-Reply-To: <s5htyh5l4zg.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

OK. I will submit the patches for National's (NSC) LM49352 and LM49350 audio cards (with older version of ALSA and Linux 2.6.24 tested). And request for the forward porting guidelines.

Thanks
Swami

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, January 19, 2011 1:07 PM
To: Reddy, MR Swami
Cc: alsa-devel@alsa-project.org
Subject: Re: Process of sumit the Audio driver code to ALSA

At Tue, 18 Jan 2011 23:20:15 -0800,
Reddy, MR Swami wrote:
> 
> Thanks for quick response!
> Yes, it  ASOC based and currently, the audio drivers supported for Samsung 6410 target.

OK, then just post your patches to alsa-devel ML, Cc'ed to ASoC maintainers (Liam Girdwood <lrg@slimlogic.co.uk> and  Mark Brown <broonie@opensource.wolfsonmicro.com>).

But I guess there have been quite many changes in ASoC core (e.g. multi-core support) that are no longer compatible with 2.6.24-based code.  These have to be fixed, of course, before merging.

It's up to you -- you can first pot the original patch and ask some hints for forward-porting, or first start reading the latest ASoC API changes, do port your driver then post the revised patch.


thanks,

Takashi

> 
> Thanks
> Swami
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, January 19, 2011 12:39 PM
> To: Reddy, MR Swami
> Subject: Re: Process of sumit the Audio driver code to ALSA
> 
> At Tue, 18 Jan 2011 20:58:28 -0800,
> Reddy, MR Swami wrote:
> > 
> > Hello,
> > We (National Semi) have developed ALSA based audio drivers for our Audio subsystem. Could you please let me know the process to submit and include as part of ALSA project.
> > 
> > The ALSA audio driver version info as follows:
> >   - Linux - 2.6.24 base
> >   - Andorid- 2.1   base
> 
> Is this based on ASoC?  If not, I recommend you to port the code to ASoC, thus it's the standard for embedded devices.
> If you have any questions, just post to alsa-devel ML.
> 
> 
> thanks,
> 
> Takashi
> 
> 
