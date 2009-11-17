From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 6/7] S3C64XX PCM: Defined PCM controller
 platform devices
Date: Tue, 17 Nov 2009 11:39:13 +0000
Message-ID: <20091117113913.GA823@rakim.wolfsonmicro.main>
References: <1258444436-24394-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFC68103856
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 12:39:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258444436-24394-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 04:53:56PM +0900, Jassi Brar wrote:

> +	default:
> +		printk(KERN_DEBUG "Invalid PCM Controller number!");
> +		return -EINVAL;
> +	}

As I said last time this really should be an error at least.
