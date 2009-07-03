From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 3/13] Intel SST driver include	headers
Date: Fri, 3 Jul 2009 12:29:52 +0100
Message-ID: <20090703112951.GD19768@sirena.org.uk>
References: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 869732484E
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 13:29:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2009 at 12:32:25PM +0530, Vinod Koul wrote:

> +struct snd_pmic_ops {
> +	int (*set_input_dev) (int value);

I'm not sure what pmic is an abbreviation for but I worry that using
this abbreviation is likely to cause confusion - PMIC normally refers to
a Power Management IC in embedded applications.
