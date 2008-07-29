From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC widgets questions
Date: Tue, 29 Jul 2008 10:23:19 +0100
Message-ID: <20080729092250.GA5931@sirena.org.uk>
References: <B082902A12CAEE4EA7FE2ED20609013B040528E2@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D58324717
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 11:23:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B082902A12CAEE4EA7FE2ED20609013B040528E2@dlee15.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2008 at 09:22:37PM -0500, Lopez Cruz, Misael wrote:

[Please word wrap your mails at 80 columns, it makes them easier to
read.]

> I started to read about ASoC, but I didn't find much information apart
> from the kernel documentation files. Is there any other documents?
> Below are some questions mainly related to DAPM for codec driver.

Apart from the mailing list archives all the documentation is in the
kernel.

> How should the interconnections map be created?

Use snd_soc_dapm_add_routes() during your codec initialisation.  This
should be done after you have set up your DAPM and non-DAPM controls.

> What is the difference between using "SND_SOC_DAPM_PGA" and
> "SND_SOC_DAPM_MICBIAS" for an input? When to use each one?

SND_SOC_DAPM_PGA is an amplifier (Programmable Gain Amplifier).

SND_SOC_DAPM_MICBIAS is a bias current source for a microphone.  Usually
any such signal on the device will be clearly identified in the
datasheet.

> Why in some codec drivers there is a distinction between left and
> right ADC/DACs when creating DAPM widgets and in others not?

It depends on what the hardware supports.  If the left and right
channels can be controlled independantly then DAPM may be able to
deliver power savings from not powering up unconnected channels but if
there is no separate power control for each channel in the hardware then
that can't be done and the DAC or ADC is represented as a single widget.

> How should be handled digital gains and mixing (after ADCs/before DACs)?

These are usually exported as regular ALSA controls added with
snd_ctl_add().

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
