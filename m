From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Tue, 21 Mar 2017 00:23:53 +0800
Message-ID: <CAAd53p4T33uKEPVHET1F-PFVbW9R-JeKoCTzYwCP7+iM+j0+qg@mail.gmail.com>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
 <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
 <20170320160622.5s2oqdyluvanjp2u@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
 [209.85.161.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E0BA266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 17:23:55 +0100 (CET)
Received: by mail-yw0-f180.google.com with SMTP id p77so93288502ywg.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 09:23:55 -0700 (PDT)
In-Reply-To: <20170320160622.5s2oqdyluvanjp2u@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 12:06 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Mar 20, 2017 at 03:46:13PM +0000, Kai-Heng Feng wrote:
>> On Mon, Mar 20, 2017 at 11:08 PM Mark Brown <broonie@kernel.org> wrote:
>
>> > As covered in SubmittingPatches this should come after the ---, it
>> > doesn't need to end up in the changelogs.
>
>> Do you mean
>> https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L197
>>  ?
>> I didn't find any hard rules regarding this, but I'll keep it in mind.
>
> As it says there "...and inserted automatically following the three dash
> line".

I saw iteration changelog in git log all over the place, maybe add a
rule section for each subsystem?

>
>> > > SND_SOC_DAPM_POST_PMD: +     case SND_SOC_DAPM_POST_PMU: +
>> > > snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE); +
>> > > break; +     case SND_SOC_DAPM_PRE_PMU:
>
> Please fix your mail client not to completely mangle quoted patches when
> replying.

Okay. I was toying with Google Inbox.

>
>> > To repeat what I said last time:
>
>> > | After power up we mute the amplifier?  That's worthy of a
>> > comment...
>
>> IIUC, HPO Power's  _POST_PMU is triggered right before power down
>> (_PRE_PMD), hence it's pretty logical to mute the amplifier at this
>> stage.  I can't quite see anything wrong here.
>
> No, that is not the case - I'm not sure what would lead you to believe
> that it is.  _POST_PMU is triggered as the last step of powering up the
> widget as the name might suggest.  Has this code been tested at all?

I had the same thought originally, but printk under each case suggests
otherwise - _POST_PMU is triggered not right after _PRE_PMU but right
before _PRE_PMD.

And yes, the patch was tested on a real machine.

>
>> So no I didn't ignore your comment, I simply misinterpreted what you
>> meant.  Because of the logical assumption, I thought you were talking
>> the unmute part in _PRE_PMU, which I did add in the changelog.
>
> You didn't reply to my review comment and you sent the same code again.
> That looks an awful lot like being ignored.

Fair enough, I thought changelog is sufficient.
