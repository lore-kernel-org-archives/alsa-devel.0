From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: tlv32aic3x, rx-51, regulator
Date: Thu, 5 Jan 2012 11:02:37 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1201051057240.13332@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [87.118.82.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 18C39245A0
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 11:02:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, Lauri Leukkunen <lauri.leukkunen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello,

the tlv320aic3x codec driver requests a number of supplies/regulators 
(IOVDD, DVDD, AVDD, DRVDD), these seem mandatory for the codec driver to 
operate and somehow tied to the rx51 platform

I want to use the tlv320aic3x codec driver with some other board where I 
don't care about supplies/regulators -- how is this going to work? do I 
need to have dummy supplies just to keep tlv320aic3x happy?

shouldn't the ai3x_supply_names be something that is optional and passed 
in via platform_data?

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
