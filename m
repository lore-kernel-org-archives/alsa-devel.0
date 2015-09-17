From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Thu, 17 Sep 2015 15:40:33 -0700
Message-ID: <CAG5mAdx+KSMfOjK2y+KKzkVjHb6HHE_W=Y_AuXE9kuom=_2Cww@mail.gmail.com>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
 <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
 <1442486431.2520.34.camel@loki>
 <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
 <20150917174242.GF12027@sirena.org.uk>
 <CAG5mAdziq11SJ3eAqDFcTEBuHJ-Rj6xwgu3kmqXC5HYOnDvYaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 879F6264F19
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 00:40:54 +0200 (CEST)
Received: by iofb144 with SMTP id b144so38672411iof.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 15:40:53 -0700 (PDT)
In-Reply-To: <CAG5mAdziq11SJ3eAqDFcTEBuHJ-Rj6xwgu3kmqXC5HYOnDvYaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, bernard.gautier@intel.com, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org

The more I think of this channel synchronization issue, the thorinier it gets.

Basically, with the TLV320AIC series of codecs, whenever any of the
DAC or ADC channels are powered up on any codec, the MCLK needs to be
stopped, all DACs/ADCs turned off, then configuration can happen, then
all DACs/ADCs can be turned back on, then MCLK starts again.  That's
the only way to ensure phase/delay accuracy among several codecs.

So, going from play-only to play+record requires MCLK be stopped, then
restarted.

Maybe it's not too terrible.  Any thoughts?

-Caleb



On Thu, Sep 17, 2015 at 11:50 AM, Caleb Crome <caleb@crome.org> wrote:
> On Thu, Sep 17, 2015 at 10:42 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Thu, Sep 17, 2015 at 06:29:58AM -0700, Caleb Crome wrote:
>>
>>> > Yes, PM suspend and resume of device. We have some scripts (to be
>>> > upstreamed later) that would play audio, suspend the device, resume the
>>> > device and then retest the audio.
>>
>>> That seems particularly likely to result in multiple codecs getting
>>> out of phase alignment.  i.e. when restarting, you want to be sure to
>>> follow the same startup procedure as the first time to make sure all
>>> codecs are aligned.
>>
>> Why should resume be any different from initial system power up?
>
> Heh, perhaps only because I don't understand how it all works :-)
>
> The example I was thinking of is if the card gets partially powered
> down.  For example, start recording on 8 channels (4 codecs, called 0,
> 1, 2, 3 in this example).  At this point, all's well, and all 4 codecs
> are in perfect phase sync.
>
> Then switch to playing 2 channel mode with codec 0 only.  Since codecs
> 1, 2, 3 are no longer needed, then they could get powered down.
>
> Then, switch back to 8 channel mode -- codec 0 is up and running, and
> now you want to turn on codecs 1, 2, 3.  At this point it's literally
> impossible to resync them with codec 0 without powering down codec 0
> and starting from scratch.  This is true of the TLV320AIC seris of
> codecs.  The CS53L30 has a dedicated sync pin on the other hand, so
> could perhaps recover gracefully in this situation.
>
> -Caleb
