From: Liam Girdwood <lrg@ti.com>
Subject: Re: Store codec capabilites in alsa
Date: Fri, 26 Oct 2012 11:45:47 +0100
Message-ID: <508A69DB.7030009@ti.com>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id DA33B265083
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 12:45:50 +0200 (CEST)
In-Reply-To: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 26/10/12 03:07, Bharath Ramachandramurthy wrote:
> Hello
> 
>  
> 
> Is there a mechanism for the codec driver to register the codec
> capabilities to the ALSA framework ? 
> 
> 

The codec DAI driver does register some of it's capabilities with the core.

 
> 
> The BE CPU dai driver can then read the capabilities of the codec and talk
> to the DSP. 
> 
> 

You should be able to do this by looking at the RTD codec->driver pointer to get supported rates, formats and channels.

Regards

Liam
