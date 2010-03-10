From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: DaVinci: Add hw_param callback for
 S/PDIF DIT link
Date: Wed, 10 Mar 2010 11:08:13 +0000
Message-ID: <1268219293.3760.29.camel@odin>
References: <1268212713-12041-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CE01243AC
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 12:08:18 +0100 (CET)
Received: by fxm20 with SMTP id 20so13868249fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 03:08:17 -0800 (PST)
In-Reply-To: <1268212713-12041-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-10 at 14:48 +0530, Chaithrika U S wrote:
> On TI DM6467 EVM, S/PDIF DIT codec fails to open as it is unable to install
> hardware params. This dummy codec has no set_fmt and set_sysclk implementations
> and calls from the application to these functions cause errors. This patch adds
> a new hardware params callback function for S/PDIF transciever codec.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> Tested-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
