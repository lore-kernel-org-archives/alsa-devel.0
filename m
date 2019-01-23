From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
Date: Wed, 23 Jan 2019 09:36:07 +0800
Message-ID: <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com> <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk> <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan> <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com> <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com> <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Rohit kumar <rohitkr@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Curtis Malainey | Software Engineer | cujomalainey@google.com | 650-898-3849


On Wed, Jan 23, 2019 at 4:11 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > The issue was that we were seeing a memory corruption bug on an AMD
> > chromebooks with that function already (not observed on Intel). I was
> > testing some SOF integrations and was seeing this in the kernel logs.
> > I had Dylan verify my logic before I sent the patch because it took so
> > long to identify the bug and it was traced to the patch that introduce
> > soc_init_platform.
> >
> > [   10.922112] cz-da7219-max98357a AMD7219:00: ASoC: CPU DAI
> > designware-i2s.1.auto not registered
> > [   10.922122] cz-da7219-max98357a AMD7219:00:
> > devm_snd_soc_register_card(acpd7219m98357) failed: -517
> > [   11.001411] cz-da7219-max98357a AMD7219:00: ASoC: Both platform
> > name/of_node are set for amd-max98357-play
> > [   11.001423] cz-da7219-max98357a AMD7219:00: ASoC: failed to init
> > link amd-max98357-play
> > [   11.001431] cz-da7219-max98357a AMD7219:00:
> > devm_snd_soc_register_card(acpd7219m98357) failed: -22
> > [   11.001577] cz-da7219-max98357a: probe of AMD7219:00 failed with error -22
> >
> > of_node was never getting set but the pointer was becoming populated
> > (outside of the probe call) which traced to soc_init_platform function
> > which was not reallocating memory on a EPROBE_DEFER even though it was
> > getting freed by devm. I am not very familiar with devm but my local
> > maintainers say that it should be freeing the memory even on a
> > PROBE_DEFER.
> > The patch should mirror the memory behaviour in
> > snd_soc_init_multicodec which also reallocates its memory on every
> > probe. I'm not sure how the patch is causing you to defer, is your
> > component list corrupt?
> >
> > Sorry for the duplicate spam, forgot to send via plain text mode,
> > re-sending for the mailing list so it gets accepted.
>
> There is no defer issue with the intel stuff, but we call this routine
> multiple times
>
> snd_soc_register_card
>
> --soc_init_dai_link
>
> ----snd_soc_init_platform
>
> -- soc_soc_bind_card
>
> ----snd_soc_instantiate_card
>
> ------ soc_check_tplg_fes
>
> -------- snd_soc_init_platform << ALLOC1
>
> --------soc_init_dai_link
>
> ----------snd_soc_init_platform << ALLOC2
>
Ah that explains it, in my testing I didn't have the patch that
brought in the call from within tplg_fes
>
> Initially dai_link->legacy_platform is 0, so gets set after the first
> first devm_kzalloc (ALLOC1) and after that we always allocate new memory
> (ALLOC2). The end result is that whatever we set in soc_check_tplg_fes
> is lost with the new/unnecessary alloc.
>
> I would guess your solution is also a work-around, if devm_ effectively
> freed the memory then the pointer would become NULL. Or may that's the
> issue is that no one actually resets it.
>
>
Yes, its a work around to fix the memory issue. If you set the
platform in the machine driver the code will ignore it and not reset
it. That being said that is not a full proof workaround and a better
solution is definitely needed. We could go and clean up the pointers
in soc_instantiate_card based on the flag being set. That way we only
relocate on a NULL pointer like we used to but still don't affect
statically allocated memory. I will draft a patch, test it on the AMD
device, reply to this thread later with it, Pierre can you test it as
well?

I am curious why soc_check_tplg_fes is calling snd_soc_init_platform.
It should have already been called earlier, in soc_init_dai_link at
the beginning of snd_soc_register_card so the memory should already be
initialized. Unless I am missing somewhere where links are getting
added between the calls.
