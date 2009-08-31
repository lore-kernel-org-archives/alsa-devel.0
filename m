From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: How to support multiple audio codecs on a single board
Date: Mon, 31 Aug 2009 14:48:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309F5A565@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A0FB24624
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 11:19:06 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7V9IwpS017040
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2009 04:19:04 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7V9IuXB018158
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2009 14:48:57 +0530 (IST)
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

Hi,

I have 3 instances of AIC23 on my board and all are connected to 
different I2C/McBSP and hence can be used independently. How should 
I use/modify the current AIC23 driver and write the asoc board-specific
file to enable all the AIC23 instances? Is there any similar 
implementation in the audio subsystem which I can look as a reference?

Regards,
Anuj Aggarwal
