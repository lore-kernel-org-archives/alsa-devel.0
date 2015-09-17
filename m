From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Thu, 17 Sep 2015 06:29:58 -0700
Message-ID: <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
 <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
 <1442486431.2520.34.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id ECBDB264ED5
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 15:30:19 +0200 (CEST)
Received: by igbkq10 with SMTP id kq10so56191909igb.0
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 06:30:18 -0700 (PDT)
In-Reply-To: <1442486431.2520.34.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, han.lu@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org

>> > We have also used BAT for stress testing audio over D0 -> D3 -> D0 transitions.
>>
>> Sorry, I'm not familiar with that terminology.  Are those the
>> different power states?
>
> Yes, PM suspend and resume of device. We have some scripts (to be
> upstreamed later) that would play audio, suspend the device, resume the
> device and then retest the audio.

That seems particularly likely to result in multiple codecs getting
out of phase alignment.  i.e. when restarting, you want to be sure to
follow the same startup procedure as the first time to make sure all
codecs are aligned.

>>
>> Anyway, in summary, the tests I'm thinking of are:
>> * Ramp test:  the gold standard for driver/SoC testing.
>> * Impulse response test:  the gold standard for phase/alignment
>>   issues.
>> * Time domain testy thingy:  a less good ramp test if you can't manage
>>   digital loopback in your system.
>
> This sounds great. Lets get the first part upstream and then we can
> incrementally add the other tests. Btw, are you going to the audio mini
> conf at ELCE in Dublin ? It would be good to discuss this in person !
>

No, not planning to go to Dublin, though it's not a bad idea.  I'm not
sure I can justify the trip there (I'm in California).  My day job is
to be a DSP/Acoustical/Electrical engineer, and I'm only hacking on
the kernel because we need to get it working :-).  Which I guess is
also my day job now too.  Make that DSP/Acoustical/Electrical/Hack
engineer.

We can always chat via Skype or phone, though I agree, there's nothing
like talking face to face.

> Liam

-Caleb
