From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/4] ASoC SST: Add mid platfrom driver
Date: Tue, 28 Dec 2010 14:52:20 +0000
Message-ID: <20101228145219.GD31883@opensource.wolfsonmicro.com>
References: <1293538258-31885-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86A421038D9
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 15:52:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293538258-31885-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 05:40:58PM +0530, Koul, Vinod wrote:

> +	/*.suspend	= intelmid_platform_suspend,
> +	.resume		= intelmid_platform_resume,*/

Remove the commented out code until it's implemeneted.

> +MODULE_DESCRIPTION("ASoC Intel(R) PLATFORM driver");
> +MODULE_AUTHOR("Harsha Priya");
> +MODULE_LICENSE("GPL v2");

MODULE_ALIAS() too.

> +#define MIN_RATE		8000
> +#define MAX_RATE		48000
> +#define MIN_CHANNEL		1
> +#define MAX_CHANNEL_AMIC	2
> +#define MAX_CHANNEL_DMIC	5
> +#define MAX_BUFFER		(800*1024)
> +#define MIN_BUFFER		(800*1024)
> +#define MIN_PERIOD_BYTES	32
> +#define MAX_PERIOD_BYTES	MAX_BUFFER
> +#define MIN_PERIODS		2
> +#define MAX_PERIODS		(1024*2)
> +#define FIFO_SIZE		0
> +#define MSIC_VENDOR_ID          0x3
> +#define SST_CARD_NAMES "intel_mid_card"

These pretty much all need namespacing; given that they're only used in
one place for the most part it'd seem as well to just not bother having
defines for them in the first place.

> +enum mid_drv_status {
> +	INIT = 1,
> +	STARTED,
> +	RUNNING,
> +	PAUSED,
> +	DROPPED,
> +};
> +
> +/* device */
> +enum SND_INPUT_DEVICE {
> +	AMIC,
> +	DMIC,
> +	HS_MIC,
> +	IN_UNDEFINED
> +};

Namespacing here too; it seems very odd that the CPU would care what's
connected to it.

> +void period_elapsed(void *mad_substream)
> +{

Staticise this or namespace it if it's used externally.
