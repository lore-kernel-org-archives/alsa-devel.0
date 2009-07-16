From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] Blackfin I2S(TDM) CPU DAI driver
Date: Thu, 16 Jul 2009 11:34:40 +0100
Message-ID: <20090716103439.GA25339@rakim.wolfsonmicro.main>
References: <1247731207-26743-1-git-send-email-21cnbao@gmail.com>
	<1247731207-26743-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17F8A246A0
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 12:34:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247731207-26743-3-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 04:00:06PM +0800, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> Even though TDM mode can be as part of I2S DAI, but there
> are so much difference in configuration and data flow,
> it's very ugly to integrate I2S and TDM into a module.

It'll be a day or two before I have the bandwidth to properly review the
code here but one thing that springs to mind reading the commit message: 
is the 2 channel I2S case not just a special case of the TDM mode?  Is
it just that the extra work required for being able to handle TDM has a
big runtime cost in buffer allocation or something and so treating it as
a special case of TDM introduces unacceptable overheads.  I'd just like
to better understand what the problems are here, I'm perfectly willing
to believe that this is a sensible solution.
