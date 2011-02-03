From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] asoc: davinci: da830/omap-l137: correct
	cpu_dai_name
Date: Thu, 3 Feb 2011 20:22:53 +0000
Message-ID: <20110203202252.GA3835@opensource.wolfsonmicro.com>
References: <1296731545-8338-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20DB3103851
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:22:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296731545-8338-1-git-send-email-vaibhav.bedia@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, davinci-linux-open-source@linux.davincidsp.com, sshtylyov@mvista.com, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 03, 2011 at 04:42:25PM +0530, Vaibhav Bedia wrote:
> McASP1 is used on the DA830/OMAP-L137 platform for the codec.
> This is different from the DA850/OMAP-L138 platform which uses McASP0.
> 
> This is fixed by adding a new snd_soc_dai_link struct.

Applied, thanks.
