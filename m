From: Vipin Kumar <vipin.kumar@st.com>
Subject: 24 bit sample embedded in 32 bits
Date: Mon, 2 Jul 2012 15:41:32 +0530
Message-ID: <4FF173D4.7060401@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B769A244AD
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 12:11:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I assume that the alsa framework expects the 24 bit sample data to be 
packed one after the other. for example while recording a 2 channel, 24 
bit sample data, typically the dma reads a fifo (which receives data 
from adc) and prepares a buffer which is then passed to the upper layers.

This buffer is expeted to be 24byte left channel and then 24 byte right 
channel. Am I right?

If the above assumption is correct, I need to find a way to tell the 
framework that the data is 24bit but is embedded in 32 bit. ie 32bit 
left and then 32 bit right channel data

I am tending to think that there has to be a way but I am unable to find 
it. Can you please point me to the right direction

Regards
Vipin
