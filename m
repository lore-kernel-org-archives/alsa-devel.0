From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack noise on Dell
 XPS 9343 I2S mode
Date: Tue, 21 Mar 2017 13:25:43 +0800
Message-ID: <CAAd53p6GLKgJR=gkA+D1Zi2WHieTeZ478CWraeGF1-neWv5ObQ@mail.gmail.com>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <20170320150845.7rltrhycdkk2mza4@sirena.org.uk> <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
 <20170320160622.5s2oqdyluvanjp2u@sirena.org.uk> <CAAd53p4T33uKEPVHET1F-PFVbW9R-JeKoCTzYwCP7+iM+j0+qg@mail.gmail.com>
 <20170320172647.t7qacxqcgawe7xlf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320172647.t7qacxqcgawe7xlf@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 1:26 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 21, 2017 at 12:23:53AM +0800, Kai-Heng Feng wrote:
>> On Tue, Mar 21, 2017 at 12:06 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > As it says there "...and inserted automatically following the three dash
>> > line".
>
>> I saw iteration changelog in git log all over the place, maybe add a
>> rule section for each subsystem?
>
> Some people won't push back, the only people who insist on anything
> different are the graphics people.

Got it. I think the way you suggested is better.

>
>> I had the same thought originally, but printk under each case suggests
>> otherwise - _POST_PMU is triggered not right after _PRE_PMU but right
>> before _PRE_PMD.
>
> Then you've broken something else on your system, that is obviously
> completely nonsensical and would break anything that relies on having a
> _POST_PMU event.  Why would we have two events that run at the same time
> one of which is obviously misnamed?

Hmm, that's weird though. I did the same test to rt286_spk_event()
(without applying the patch I sent), what I observed was the same:
_POST_PMU was triggered right after I stopped play sound, i.e. right
before _PRE_PMD not right after _PRE_PMU.

>
>> > > You didn't reply to my review comment and you sent the same code
>> > > again.
>> > That looks an awful lot like being ignored.
>
>> Fair enough, I thought changelog is sufficient.
>
> I'm not seeing anything in the changelog that addresses this.
