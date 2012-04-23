From: "Raj, Deepu" <deepu.raj@ti.com>
Subject: ALSA HDMI  Audio Hot Plug Detect functionality
Date: Mon, 23 Apr 2012 11:32:34 +0000
Message-ID: <9B3D272F39948B4D87370C6AAD38EEC73E921D01@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E7D824511
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 13:32:39 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q3NBWaih018362
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2012 06:32:37 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q3NBWYPS001364
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2012 17:02:35 +0530 (IST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

All,

Can someone help me on how to implement the HPD function in ALSA soc driver?

In my case the Video driver is already registered an IRQ for the HDP detect and doing all the configurations for the video part.
How can I integrate a call or some other mechanism to the dummy codec driver where I am using the audio configurations?
All the hdmi configuration functions are implemented in a hdmi_lib.c and accessed from the dummy codec driver.

Thanks & Regards
Deepu Raj
