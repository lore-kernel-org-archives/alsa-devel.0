From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH] ASoC: Davinci: Replace use of IO_ADDRESS
	with ioremap()
Date: Fri, 17 Dec 2010 09:46:30 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F3AB987@dbde02.ent.ti.com>
References: <1292491018-24491-1-git-send-email-vaibhav.bedia@ti.com>
	<4D09F439.9010404@mvista.com>
	<FCCFB4CDC6E5564B9182F639FC356087035F30217D@dbde02.ent.ti.com>
	<4D0A0ACF.2010901@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 1743510382B
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 05:16:44 +0100 (CET)
In-Reply-To: <4D0A0ACF.2010901@mvista.com>
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

On Thursday, December 16, 2010 6:19 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 16-12-2010 14:41, Bedia, Vaibhav wrote:
> 
>>>>    err_free_mem:
> 
>>>      Don't you forget to call clk_disable()/clk_put()?
> 
>> Will fix this issue also as part of the patch.
> 
>     No, this is different issue -- please submit another patch.
> 
>>>    	release_mem_region(mem->start, (mem->end - mem->start) + 1);
>>>    err_release_data:
> 

Seems like multiple issues can be fixed in the driver. Will send patches for those also.


Regards,
Vaibhav
