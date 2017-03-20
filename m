From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 20 Mar 2017 15:46:13 +0000
Message-ID: <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com
 [209.85.161.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E8D266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 16:46:24 +0100 (CET)
Received: by mail-yw0-f182.google.com with SMTP id p77so92528151ywg.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 08:46:24 -0700 (PDT)
In-Reply-To: <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 11:08 PM Mark Brown <broonie@kernel.org> wrote:

> On Mon, Mar 20, 2017 at 11:58:31AM +0800, Kai-Heng Feng wrote:
>
> > v3:
> > Implicit conversion instead of tenary operator.
> >
> > v2:
> > Use 'HP Power' instead of individual power events.
>
> As covered in SubmittingPatches this should come after the ---, it
> doesn't need to end up in the changelogs.
>

Do you mean
https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L197
 ?
I didn't find any hard rules regarding this, but I'll keep it in mind.


>
> > +     switch (event) {
> > +     case SND_SOC_DAPM_PRE_PMD:
> > +     case SND_SOC_DAPM_POST_PMD:
> > +     case SND_SOC_DAPM_POST_PMU:
> > +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> > +             break;
> > +     case SND_SOC_DAPM_PRE_PMU:
>
> To repeat what I said last time:
>
> | After power up we mute the amplifier?  That's worthy of a comment...




> Please don't ignore review comments, people are generally making them
> for a reason and are likely to have the same concerns if issues remain
> unaddressed.  Having to repeat the same comments can get repetitive and
> make people question the value of time spent reviewing.  If you disagree
> with the review comments that's fine but you need to reply and discuss
> your concerns so that the reviewer can understand your decisions.
>

IIUC, HPO Power's  _POST_PMU is triggered right before power down
(_PRE_PMD), hence it's pretty logical to mute the amplifier at this stage.
I can't quite see anything wrong here.

So no I didn't ignore your comment, I simply misinterpreted what you meant.
Because of the logical assumption, I thought you were talking the unmute
part in _PRE_PMU, which I did add in the changelog.

Again, what's the issue here?
