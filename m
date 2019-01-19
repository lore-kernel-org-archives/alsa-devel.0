From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Fri, 18 Jan 2019 17:12:25 -0800
Message-ID: <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 64040266BE8
 for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2019 02:12:38 +0100 (CET)
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so13087420ljh.13
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 17:12:38 -0800 (PST)
In-Reply-To: <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Rohit kumar <rohitkr@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2019 at 3:02 PM Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

>
> On 1/15/19 3:16 PM, Pierre-Louis Bossart wrote:
> >
> >>> Beyond the fact that the platform_name seems to be totally useless,
> >>> additional tests show that the patch ('ASoC: soc-core: defer card probe
> >>> until all component is added to list') adds a new restriction which
> >>> contradicts existing error checks.
> >>>
> >>> None of the Intel machine drivers set the dailink "cpu_name" field
> >>> but use
> >>> the "cpu_dai_name" field instead. This was perfectly legit as
> >>> documented by
> >>> the code at the end of soc_init_dai_link()
> >> This should be fixed by the patch
> >> "ASoC: core: Don't defer probe on optional, NULL components" which Mark
> >> already applied to his tree. See
> >>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.html
> >>
> >
> > Ah yes, I missed this patch while I was debugging. Indeed this fixes
> > the problem and my devices work again with Mark's for-next branch.
> > Thanks Matthias!
>
> This PROBE_DEFER support actually breaks the topology override that
> we've been relying on for SOF (and which has been in Mark's branch for
> some time now). This override helps us reuse machine drivers between
> legacy and SOF-based solutions.
>
> With the current code, the tests in soc_register_card() complain that
> the platform_name can't be tied to a component and stop the card
> registration, but that's mainly because the tests are done before the
> topology overrides are done in soc_check_tplg_fes(). Moving
> soc_check_tplg_fes() from soc_instantiate_card() to an earlier time in
> soc_register_card() works-around the problem but looks quite invasive
> (mutex lock, etc).
>
> There is also a second problem where we seem to have a memory management
> issue root caused to the change in snd_soc_init_platform() added by
> 09ac6a817bd6 ('ASoC: soc-core: fix init platform memory handling')
>
> The code does this
>
> static int snd_soc_init_platform(struct snd_soc_card *card,
>                   struct snd_soc_dai_link *dai_link)
> {
>      struct snd_soc_dai_link_component *platform = dai_link->platform;
>
>
>      /* convert Legacy platform link */
>      if (!platform || dai_link->legacy_platform) {
>          platform = devm_kzalloc(card->dev,
>                  sizeof(struct snd_soc_dai_link_component),
>                  GFP_KERNEL);
>          if (!platform)
>              return -ENOMEM;
>
>          dai_link->platform      = platform;
>          dai_link->legacy_platform = 1;
>
> This last assignment guarantees that memory will be allocated every time
> this function is called, and whatever overrides are done later will
> themselves be overridden by the new allocation. I am not sure what the
> intent was here, Curtis can you please double-check?
>
> The issue was that we were seeing a memory corruption bug on an AMD
chromebooks with that function already (not observed on Intel). I was
testing some SOF integrations and was seeing this in the kernel logs. I had
Dylan verify my logic before I sent the patch because it took so long to
identify the bug and it was traced to the patch that introduce
soc_init_platform.

[   10.922112] cz-da7219-max98357a AMD7219:00: ASoC: CPU DAI
designware-i2s.1.auto not registered
[   10.922122] cz-da7219-max98357a AMD7219:00:
devm_snd_soc_register_card(acpd7219m98357) failed: -517
[   11.001411] cz-da7219-max98357a AMD7219:00: ASoC: Both platform
name/of_node are set for amd-max98357-play
[   11.001423] cz-da7219-max98357a AMD7219:00: ASoC: failed to init link
amd-max98357-play
[   11.001431] cz-da7219-max98357a AMD7219:00:
devm_snd_soc_register_card(acpd7219m98357) failed: -22
[   11.001577] cz-da7219-max98357a: probe of AMD7219:00 failed with error
-22

of_node was never getting set but the pointer was becoming populated
(outside of the probe call) which traced to soc_init_platform function
which was not reallocating memory on a EPROBE_DEFER even though it was
getting freed by devm. I am not very familiar with devm but my local
maintainers say that it should be freeing the memory even on a PROBE_DEFER.
The patch should mirror the memory behaviour in snd_soc_init_multicodec
which also reallocates its memory on every probe. I'm not sure how the
patch is causing you to defer, is your component list corrupt?

Details, test code and logs are available here:
> https://github.com/thesofproject/linux/issues/565
>
> Have a nice week-end everyone, that's it for me until Tuesday.
>
> -Pierre
>
>
>
>
