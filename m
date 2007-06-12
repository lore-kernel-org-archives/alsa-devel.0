From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: [ASoC] Missing shutdown() vectors in ASoC
Date: Tue, 12 Jun 2007 12:34:27 +0530
Message-ID: <8d6898730706120004u31ddc1edj9e38e575b6aa5e53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id B0EC8103837
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 09:04:28 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2537842wag
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2007 00:04:27 -0700 (PDT)
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

Liam,

Shutdown() vectors is missing in ASoC, we need this to ensure proper
shutdown of the system.

* codec device */
struct snd_soc_codec_device {
	int (*probe)(struct platform_device *pdev);
	int (*remove)(struct platform_device *pdev);
	int (*suspend)(struct platform_device *pdev, pm_message_t state);
	int (*resume)(struct platform_device *pdev);
};

/* SoC CPU DAI */
struct snd_soc_cpu_dai {

	/* DAI description */
	char *name;
	unsigned int id;
	unsigned char type;

	/* DAI callbacks */
	int (*probe)(struct platform_device *pdev);
	void (*remove)(struct platform_device *pdev);
	int (*suspend)(struct platform_device *pdev,
		struct snd_soc_cpu_dai *cpu_dai);
	int (*resume)(struct platform_device *pdev,
		struct snd_soc_cpu_dai *cpu_dai);
	unsigned int (*config_sysclk)(struct snd_soc_cpu_dai *cpu_dai,
		struct snd_soc_clock_info *info, unsigned int clk);

	/* DAI capabilities */
	struct snd_soc_pcm_stream capture;
	struct snd_soc_pcm_stream playback;
	struct snd_soc_dai_cap caps;


/* SoC platform interface */
struct snd_soc_platform {
	char *name;

	int (*probe)(struct platform_device *pdev);
	int (*remove)(struct platform_device *pdev);
	int (*suspend)(struct platform_device *pdev,
		struct snd_soc_cpu_dai *cpu_dai);
	int (*resume)(struct platform_device *pdev,
		struct snd_soc_cpu_dai *cpu_dai);

	/* pcm creation and destruction */



/* SoC machine */
struct snd_soc_machine {
	char *name;

	int (*probe)(struct platform_device *pdev);
	int (*remove)(struct platform_device *pdev);

	/* the pre and post PM functions are used to do any PM work before and
	 * after the codec and DAI's do any PM work. */
	int (*suspend_pre)(struct platform_device *pdev, pm_message_t state);
	int (*suspend_post)(struct platform_device *pdev, pm_message_t state);
	int (*resume_pre)(struct platform_device *pdev);
	int (*resume_post)(struct platform_device *pdev);



Nobin Mathew
