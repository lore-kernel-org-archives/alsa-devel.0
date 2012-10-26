From: Sebastien LEDUC <sebastien.leduc@st.com>
Subject: question on snd_soc_dai_link_event
Date: Fri, 26 Oct 2012 13:58:54 +0200
Message-ID: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
 [207.126.144.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 76A18265107
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 13:59:11 +0200 (CEST)
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
Cc: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I have one question about current implementation of function snd_soc_dai_link_event
Currently, on power up, it calls hw_params on the source and sink dai drivers, and digital_mute(0) on the sink dai driver

I wonder why it does not call the full hw_params / prepare / trigger sequence on both dai drivers to start the 2 DAIs.

Thanks in advance
Regards,
Sebastien 
