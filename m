From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add support for multiple jack types
Date: Wed, 9 Feb 2011 23:02:35 +0000
Message-ID: <20110209230234.GA28118@opensource.wolfsonmicro.com>
References: <1297242857-18663-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C41A01039C0
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 00:02:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297242857-18663-1-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 09, 2011 at 02:44:17PM +0530, Koul, Vinod wrote:

> +int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage);

Applied, thanks.  It ocurred to me that there might be a better name for
this function that makes it clear what we're using to do the
identification but I can't think of one right now.
