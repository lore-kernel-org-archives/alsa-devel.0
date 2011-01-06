From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Thu, 6 Jan 2011 11:01:30 -0600
Message-ID: <4D25F56A.5060903@freescale.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>	
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>	
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<1294332806.19933.5.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 47AD51037F9
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 18:01:38 +0100 (CET)
In-Reply-To: <1294332806.19933.5.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> The semantics behind this code is that if the driver provides a
> reg_cache_size and a reg_word_size it *should* provide a defaults
> register cache as well.

I *had* code which did this, but apparently it broke somewhere.  Oh well.

>  If you want to manage your own register cache
> in the driver which is not advised, you will have to add similar
> functionality in your _priv struct.  If you require more flexible
> functionality you need to consider implementing a sensible strategy and
> submitting it as a patch.

I will fix my driver to restore the functionality.

-- 
Timur Tabi
Linux kernel developer at Freescale
