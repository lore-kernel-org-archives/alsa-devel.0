From: Liam Girdwood <lrg@ti.com>
Subject: Re: dynamic PCM and dynamic DSP graphs
Date: Fri, 19 Oct 2012 15:36:28 +0100
Message-ID: <5081656C.5060207@ti.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA29EC8998@SAFEX1MAIL1.st.com>
 <508130BD.4060909@ti.com>
 <9C1683ABA24673439FCD019782C9F4BBDA29EC89CA@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BF7265B6C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 16:36:32 +0200 (CEST)
In-Reply-To: <9C1683ABA24673439FCD019782C9F4BBDA29EC89CA@SAFEX1MAIL1.st.com>
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

On 19/10/12 12:56, Sebastien LEDUC wrote:
> 
> Hi Liam,
> Thank for the quick reply
> 
>> Will this not race against the graph walk ? as it sounds like you are changing the graph during the DAPM walk here.
> 
> No, we are not changing the DAPM graph during the graph walk.
> We are only changing the DSP graph
> 
>> I think the consensus reached at plumbers was that we would use the media framework API to export the graph information to userspace and also allow userspace to change the graph objects and routing (via media framework APIs). The media framework guys were > happy to support this albeit the media framework is missing some functionality to remove graph objects atm (iirc it can currently add and change graph objects).
> 
> How will this interact with the DSP DAPM graph?
> 

I've not looked into the mechanics of the media interface DAPM integration yet, but we will just use media frameworks existing APIs to visualize and modify the card DAPM graph in userspace (we can also visualize some attributes for paths and widgets too).

The intention is for userspace to create/destroy/modify the DAPM DSP graph per use case. i.e. we would be able to add/rm new widgets and paths depending on use case transitions which could be: to improve DSP performance, lower DSP power, to fit within DSP resourcing constraints. e.g. we could remove a DAPM mixer widget from the output DSP DAPM path to conserve DSP power and memory for other tasks. 

Regards

Liam
