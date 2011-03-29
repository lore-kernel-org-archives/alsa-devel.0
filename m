From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 3/5] sound: asoc: Adding support for
 SPEAr13XX ASoC machine driver
Date: Wed, 30 Mar 2011 08:32:20 +0900
Message-ID: <20110329233219.GL30482@opensource.wolfsonmicro.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B2649103816
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 01:32:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 29, 2011 at 04:47:01PM +0530, Rajeev Kumar wrote:

> +	/* Create and register platform device */
> +	evb_snd_device = platform_device_alloc("soc-audio", 0);
> +	if (!evb_snd_device) {
> +		printk(KERN_ERR "platform_device_alloc fails\n");
> +		return -ENOMEM;
> +	}

It's better to use snd_soc_register_card() rather than using the
soc-audio device with current kernels
