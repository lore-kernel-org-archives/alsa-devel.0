From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Minor improvements
Date: Thu, 11 Oct 2012 16:18:00 +0900
Message-ID: <20121011071759.GC11726@opensource.wolfsonmicro.com>
References: <1349870093.13275.16.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07CD42616DA
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:18:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1349870093.13275.16.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 10, 2012 at 05:24:53PM +0530, Ashish Chavan wrote:
> This patch includes two minor improvements for da9055 codec driver
> 
> (1) Adding support for DSP mode of AIF
> (2) Muting Mic PGAs during ALC calibration process

Send one patch per change.  I suspect the second change is a bug fix
rather than an new feature so should go in separately anyway...
