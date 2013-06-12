From: Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL] ASoC updates for v3.10
Date: Wed, 12 Jun 2013 21:10:05 +0200
Message-ID: <CAH5Jhw9jeYESNqeCXudujfG9MyQ=bu0_J0Y8pF2D8aUk_hbYUg@mail.gmail.com>
References: <20130610101644.GQ31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE74265151
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 21:10:06 +0200 (CEST)
Received: by mail-la0-f47.google.com with SMTP id fe20so8238979lab.20
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 12:10:05 -0700 (PDT)
In-Reply-To: <20130610101644.GQ31367@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, takashi.iwai@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I'm currently traveling, and will pull it after back from that, so it may
slip the upcoming rc.
If needed, feel free ask Linus to pull directly.

Thanks,

Takashi
On Jun 10, 2013 12:19 PM, "Mark Brown" <broonie@kernel.org> wrote:

> The following changes since commit
> 317ddd256b9c24b0d78fa8018f80f1e495481a10:
>
>   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.gittags/aso=
c-v3.10-rc5
>
> for you to fetch changes up to 902a75cdc491066514aac35b40a756aaa9740173:
>
>   Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus
> (2013-06-10 10:28:51 +0100)
>
> ----------------------------------------------------------------
>
> ASoC: Updates for v3.10
>
> As well as the usual driver specifics we've got a couple of core fixes
> here, one fixing capabilities for unidirectional streams and the other
> fixing suspend while audio streams are active.  The suspend fix is a
> little involved but mostly as a result of removing some special casing
> that was doing the wrong thing.
>
> ----------------------------------------------------------------
> Andreas Irest=E5l (1):
>       ASoC: tlv320aic3x: Remove deadlock from
> snd_soc_dapm_put_volsw_aic3x()
>
> Charles Keepax (1):
>       ASoC: arizona: Correct AEC loopback enable
>
> Mark Brown (11):
>       ASoC: wm8994: Avoid leaking pm_runtime reference on removed jack ra=
ce
>       ASoC: wm8994: Ensure microphone detection state is reset on removal
>       MAINTAINERS: Remove myself from Wolfson maintainers
>       ASoC: pcm: Require both CODEC and CPU support when declaring stream
> caps
>       ASoC: dapm: Treat DAI widgets like AIF widgets for power
>       Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/cs42l52' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/maintainers' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-linus
>       Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus
>
> Nicolas Schichan (2):
>       ASoC: cs42l52: use correct PCM mixer TLV dB scale to match datashee=
t.
>       ASoC: cs42l52: fix hp_gain_enum shift value.
>
>  MAINTAINERS                    |    3 +--
>  include/sound/soc-dapm.h       |    3 ++-
>  sound/soc/codecs/cs42l52.c     |    6 +++--
>  sound/soc/codecs/tlv320aic3x.c |   10 ++++----
>  sound/soc/codecs/wm5102.c      |    3 ++-
>  sound/soc/codecs/wm5110.c      |    3 ++-
>  sound/soc/codecs/wm8994.c      |    3 ++-
>  sound/soc/soc-dapm.c           |   49
> +++++++++++++++++++++-------------------
>  sound/soc/soc-pcm.c            |   13 ++++++++---
>  9 files changed, 54 insertions(+), 39 deletions(-)
>
