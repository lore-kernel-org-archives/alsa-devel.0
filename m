From: Timur Tabi <timur@freescale.com>
Subject: snd_soc_dai_link.init()
Date: Wed, 30 May 2007 17:34:29 -0500
Message-ID: <465DFBF5.9040800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D6212452D
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 00:34:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam,

Why does the init() function pointer in the snd_soc_dai_link structure take a 
snd_soc_codec pointer?  Wouldn't it make more sense for it to take a snd_soc_dai_link 
pointer?  That way, I could use the init() function to initialize the structure.

I'm trying to write a function that will initialize the codec_dai pointer.  I thought I 
could use snd_soc_dai_link.init(), but I don't know how to get the pointer to the 
snd_soc_dai_link structure from a snd_soc_codec structure.



/* SoC machine DAI configuration, glues a codec and cpu DAI together */
struct snd_soc_dai_link  {
	char *name;			/* Codec name */
	char *stream_name;		/* Stream name */

	/* DAI */
	struct snd_soc_codec_dai *codec_dai;
	struct snd_soc_cpu_dai *cpu_dai;

	/* machine stream operations */
	struct snd_soc_ops *ops;

	/* codec/machine specific init - e.g. add machine controls */
	int (*init)(struct snd_soc_codec *codec);
};


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
