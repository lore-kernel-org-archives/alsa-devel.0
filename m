From: Sebastien LEDUC <sebastien.leduc@st.com>
Subject: Re: dynamic PCM and dynamic DSP graphs
Date: Fri, 19 Oct 2012 13:56:12 +0200
Message-ID: <9C1683ABA24673439FCD019782C9F4BBDA29EC89CA@SAFEX1MAIL1.st.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA29EC8998@SAFEX1MAIL1.st.com>
 <508130BD.4060909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog107.obsmtp.com (eu1sys200aog107.obsmtp.com
 [207.126.144.123])
 by alsa0.perex.cz (Postfix) with ESMTP id C097D265338
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 13:56:58 +0200 (CEST)
In-Reply-To: <508130BD.4060909@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


Hi Liam,
Thank for the quick reply

> Will this not race against the graph walk ? as it sounds like you are changing the graph during the DAPM walk here.

No, we are not changing the DAPM graph during the graph walk.
We are only changing the DSP graph

> I think the consensus reached at plumbers was that we would use the media framework API to export the graph information to userspace and also allow userspace to change the graph objects and routing (via media framework APIs). The media framework guys were > happy to support this albeit the media framework is missing some functionality to remove graph objects atm (iirc it can currently add and change graph objects).

How will this interact with the DSP DAPM graph?

Regards,
Sebastien
