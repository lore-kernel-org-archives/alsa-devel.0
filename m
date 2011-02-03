From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] asoc: davinci: da830/omap-l137: correct
 cpu_dai_name
Date: Thu, 03 Feb 2011 16:15:17 +0000
Message-ID: <1296749717.3456.122.camel@odin>
References: <1296731545-8338-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A766B103A85
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 17:15:22 +0100 (CET)
Received: by wyi11 with SMTP id 11so1252848wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Feb 2011 08:15:21 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com, sshtylyov@mvista.com, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-03 at 16:42 +0530, Vaibhav Bedia wrote:
> McASP1 is used on the DA830/OMAP-L137 platform for the codec.
> This is different from the DA850/OMAP-L138 platform which uses McASP0.
> 
> This is fixed by adding a new snd_soc_dai_link struct.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
> 
> v2: 
> Fixed the subject as pointed out by Sergei.
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
