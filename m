From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ASoC] Missing shutdown() vectors in ASoC
Date: Tue, 12 Jun 2007 17:44:36 +0530
Message-ID: <8d6898730706120514na050b79j813ba93db23dc768@mail.gmail.com>
References: <8d6898730706120004u31ddc1edj9e38e575b6aa5e53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AEF92455E
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 14:14:38 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2618985wag
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2007 05:14:36 -0700 (PDT)
In-Reply-To: <8d6898730706120004u31ddc1edj9e38e575b6aa5e53@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam

I am trying to implement shutdown in ASoC

/* dapm stream operations */
#define SND_SOC_DAPM_STREAM_NOP			0x0
#define SND_SOC_DAPM_STREAM_START		0x1
#define SND_SOC_DAPM_STREAM_STOP		0x2
#define SND_SOC_DAPM_STREAM_SUSPEND		0x4
#define SND_SOC_DAPM_STREAM_RESUME		0x8
#define SND_SOC_DAPM_STREAM_PAUSE_PUSH	0x10
#define SND_SOC_DAPM_STREAM_PAUSE_RELEASE	0x20


Is there any need to add stream operation called
SND_SOC_DAPM_STREAM_SHUTDOWN even though this has no effect no the
system behaviour.

Instead we can use SND_SOC_DAPM_STREAM_SUSPEND.
Is this OK.

is there any better way to implement suspend?, i think suspend will be
a copy of remove() function.



On 6/12/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Liam,
>
> Shutdown() vectors is missing in ASoC, we need this to ensure proper
> shutdown of the system.
>
> * codec device */
> struct snd_soc_codec_device {
>         int (*probe)(struct platform_device *pdev);
>         int (*remove)(struct platform_device *pdev);
>         int (*suspend)(struct platform_device *pdev, pm_message_t state);
>         int (*resume)(struct platform_device *pdev);
> };
>
> /* SoC CPU DAI */
> struct snd_soc_cpu_dai {
>
>         /* DAI description */
>         char *name;
>         unsigned int id;
>         unsigned char type;
>
>         /* DAI callbacks */
>         int (*probe)(struct platform_device *pdev);
>         void (*remove)(struct platform_device *pdev);
>         int (*suspend)(struct platform_device *pdev,
>                 struct snd_soc_cpu_dai *cpu_dai);
>         int (*resume)(struct platform_device *pdev,
>                 struct snd_soc_cpu_dai *cpu_dai);
>         unsigned int (*config_sysclk)(struct snd_soc_cpu_dai *cpu_dai,
>                 struct snd_soc_clock_info *info, unsigned int clk);
>
>         /* DAI capabilities */
>         struct snd_soc_pcm_stream capture;
>         struct snd_soc_pcm_stream playback;
>         struct snd_soc_dai_cap caps;
>
>
> /* SoC platform interface */
> struct snd_soc_platform {
>         char *name;
>
>         int (*probe)(struct platform_device *pdev);
>         int (*remove)(struct platform_device *pdev);
>         int (*suspend)(struct platform_device *pdev,
>                 struct snd_soc_cpu_dai *cpu_dai);
>         int (*resume)(struct platform_device *pdev,
>                 struct snd_soc_cpu_dai *cpu_dai);
>
>         /* pcm creation and destruction */
>
>
>
> /* SoC machine */
> struct snd_soc_machine {
>         char *name;
>
>         int (*probe)(struct platform_device *pdev);
>         int (*remove)(struct platform_device *pdev);
>
>         /* the pre and post PM functions are used to do any PM work before and
>          * after the codec and DAI's do any PM work. */
>         int (*suspend_pre)(struct platform_device *pdev, pm_message_t state);
>         int (*suspend_post)(struct platform_device *pdev, pm_message_t state);
>         int (*resume_pre)(struct platform_device *pdev);
>         int (*resume_post)(struct platform_device *pdev);
>
>
>
> Nobin Mathew
>
