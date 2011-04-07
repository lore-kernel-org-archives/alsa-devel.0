From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: fix compile error
Date: Thu, 7 Apr 2011 08:50:31 +0100
Message-ID: <20110407075031.GD14519@opensource.wolfsonmicro.com>
References: <20110407021813.5372.82489.stgit@localhost>
	<20110407062717.GA14519@opensource.wolfsonmicro.com>
	<20110407064420.GC8484@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E11710384F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 09:50:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110407064420.GC8484@qtel.sh.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "gregkh@suse.de`" <gregkh@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2011 at 02:44:20PM +0800, Lu Guanqun wrote:

> This compile error is actually caused by my fault, see below commit.

Ah, OK, it's a change I've applied in my tree that introduces the issue
- I'll apply your fix next time I run through patches.
