From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: check channel mismatch between
 cpu_dai and codec_dai
Date: Thu, 7 Apr 2011 08:25:38 +0900
Message-ID: <20110406232533.GA5766@opensource.wolfsonmicro.com>
References: <20110406152511.32471.28875.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18A0E10386A
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 01:25:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110406152511.32471.28875.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 06, 2011 at 11:25:11PM +0800, Lu Guanqun wrote:
> Suppose we have:
> 
> 	cpu_dai
> 		channels_min = 1
> 		channels_max = 1

Applied both, thanks.
