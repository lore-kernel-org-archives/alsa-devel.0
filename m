From: Sebastien LEDUC <sebastien.leduc@st.com>
Subject: dynamic PCM and dynamic DSP graphs
Date: Fri, 19 Oct 2012 11:39:22 +0200
Message-ID: <9C1683ABA24673439FCD019782C9F4BBDA29EC8998@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
 [207.126.144.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 5159326532C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 11:39:26 +0200 (CEST)
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D6D1E8
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 09:39:25 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas4.st.com [10.75.90.69])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 539A4286A
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 09:39:25 +0000 (GMT)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark / Liam,
We have started to use Dynamic PCM to manage our on-SoC DSP.
In our case, the API exposed by the DSP is graph oriented, and allows to dynamically create and control the running graph on the DSP.

What we are doing is that we use DAPM widgets and routes to manage  the DSP graph dynamically:
We use some dedicated widgets that have power callbacks. 
When a  widget is powered on/off, the callback will use the DSP API to create/destroy the corresponding parts of the DSP graph.

We wanted to get your feedback on this approach, so as to be sure it won't be an issue when we want to mainline our driver.
We can of course share more details if needed, or even some preliminary version of the driver.

Thanks in advance for your feedback

Regards
Sebastien

 
 
