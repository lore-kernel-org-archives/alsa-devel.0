From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Fri, 18 Sep 2015 10:09:07 +0100
Message-ID: <1442567347.7634.12.camel@loki>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
 <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
 <1442486431.2520.34.camel@loki>
 <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 388B32604D3
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:09:14 +0200 (CEST)
In-Reply-To: <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Takashi Iwai <tiwai@suse.de>, han.lu@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-17 at 06:29 -0700, Caleb Crome wrote:
> >> > We have also used BAT for stress testing audio over D0 -> D3 -> D0 transitions.
> >>
> >> Sorry, I'm not familiar with that terminology.  Are those the
> >> different power states?
> >
> > Yes, PM suspend and resume of device. We have some scripts (to be
> > upstreamed later) that would play audio, suspend the device, resume the
> > device and then retest the audio.
> 
> That seems particularly likely to result in multiple codecs getting
> out of phase alignment.  i.e. when restarting, you want to be sure to
> follow the same startup procedure as the first time to make sure all
> codecs are aligned.
> 

This was more for testing our DSP and codec context was properly
saved/restored and also our codec was properly powered down/up during PM
state changes.

Liam
