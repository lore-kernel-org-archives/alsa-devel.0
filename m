From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
 Interface driver.
Date: Wed, 27 Mar 2019 15:46:33 +0200
Message-ID: <CAEnQRZBTjaHVPe=iW7f7ohJHNNaZBcPr_hv6dO7ng_CiQjaxdw@mail.gmail.com>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
 <f3a0f305-dc96-f8b9-3c57-e45256326e2f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86D60F8071D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 14:46:44 +0100 (CET)
Received: by mail-ed1-x544.google.com with SMTP id d26so14045671ede.10
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 06:46:44 -0700 (PDT)
In-Reply-To: <f3a0f305-dc96-f8b9-3c57-e45256326e2f@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 14, 2018 at 10:09 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 12/12/18 12:14 PM, Mark Brown wrote:
> >> +static irqreturn_t voice_detected_fn(int irq, void *devid)
> >> +{
> >> +    struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
> >> +    struct device *dev = &micfil->pdev->dev;
> >> +    int ret;
> >> +
> >> +    /* disable hwvad */
> >> +    ret = disable_hwvad(dev, true);
> >> +    if (ret)
> >> +            dev_err(dev, "Failed to disable HWVAD module\n");
> >> +
> >> +    /* notify userspace that voice was detected */
> >> +    kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
> >> +
> >> +    return IRQ_HANDLED;
> >> +}
> > So, this looks like it's intended to be used for keyword detection type
> > applications (though without the offload DSP that those tend to have).
> > What the other implementations I've seen have ended up doing is using a
> > compressed audio stream to return the audio data to userspace, allowing
> > the audion stream to be paused when no audio is detected.  Your approach
> > here is a bit more manual and may be more sensible for systems without
> > the offload DSP however the decision to go outside ALSA and use a
> > kobject needs to be thought about a bit, we'd want to ensure that
> > there's a standard way of handling hardware like this so applications
> > can work as consistently as possible with them.
>
> There's no mention of any buffer so it's likely plain vanilla VAD here.
> We've seen two choices to warn userspace of a acoustic event, either use
> a uevent or a kcontrol. I believe we ended-up chosing the latter on the
> Intel side in the past and that was also the plan for SOF.

Reviving this discussion about VAD. Do you have any draft patches for
the interface to send events to user space?

We are now trying to upstream VAD for PDM and we are looking
at all our options.

thanks,
Daniel.
