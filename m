From: Liam Girdwood <lrg@ti.com>
Subject: Re: dynamic PCM and dynamic DSP graphs
Date: Fri, 19 Oct 2012 11:51:41 +0100
Message-ID: <508130BD.4060909@ti.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA29EC8998@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A437E26532C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 12:51:44 +0200 (CEST)
In-Reply-To: <9C1683ABA24673439FCD019782C9F4BBDA29EC8998@SAFEX1MAIL1.st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien LEDUC <sebastien.leduc@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Sebastien,

Best to always CC Mark and I if you want a quicker reply from either of us.

On 19/10/12 10:39, Sebastien LEDUC wrote:
> Hi Mark / Liam,
> We have started to use Dynamic PCM to manage our on-SoC DSP.
> In our case, the API exposed by the DSP is graph oriented, and allows to dynamically create and control the running graph on the DSP.

Runtime DAPM graph update was a topic brought up at the recent plumbers conference in San Diego.......

> What we are doing is that we use DAPM widgets and routes to manage  the DSP graph dynamically:
> We use some dedicated widgets that have power callbacks. 
> When a  widget is powered on/off, the callback will use the DSP API to create/destroy the corresponding parts of the DSP graph.

Will this not race against the graph walk ? as it sounds like you are changing the graph during the DAPM walk here.

> We wanted to get your feedback on this approach, so as to be sure it won't be an issue when we want to mainline our driver.
> We can of course share more details if needed, or even some preliminary version of the driver.
> 
> Thanks in advance for your feedback

I think the consensus reached at plumbers was that we would use the media framework API to export the graph information to userspace and also allow userspace to change the graph objects and routing (via media framework APIs). The media framework guys were happy to support this albeit the media framework is missing some functionality to remove graph objects atm (iirc it can currently add and change graph objects).

It was agreed at plumbers that I would add graph removal support to the media framework but I still have to complete the upstream of firmware graph/mixer support and the OMAP4 ABE first (another 3 months). Please do feel free to add this support if you need it quicker.

Does this sound like it would fit with your driver use case for graph updates ? It certainly seemed to fit in with the other HW vendors at plumbers with similar architectures.

Regards

Liam

> 
> Regards
> Sebastien
> 
>  
>  
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
