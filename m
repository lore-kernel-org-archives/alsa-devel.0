From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH] ASoC: Davinci: Replace use of IO_ADDRESS
	with ioremap()
Date: Thu, 16 Dec 2010 17:11:09 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F30217D@dbde02.ent.ti.com>
References: <1292491018-24491-1-git-send-email-vaibhav.bedia@ti.com>
	<4D09F439.9010404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id DB7EE2437E
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 12:41:22 +0100 (CET)
In-Reply-To: <4D09F439.9010404@mvista.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday, December 16, 2010 4:43 PM, Sergei Shtylyov wrote:
[...]
> 
>     Why iounmap() what you've just failed to ioremap()?
> 
Will fix this.

[...]
>>   err_free_mem:
> 
>     Don't you forget to call clk_disable()/clk_put()?
> 
Will fix this issue also as part of the patch.

>   	release_mem_region(mem->start, (mem->end - mem->start) + 1);
>   err_release_data:

Regards,
Vaibhav
