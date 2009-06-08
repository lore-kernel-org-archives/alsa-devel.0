From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Default enabling of mixer controls
Date: Mon, 8 Jun 2009 17:40:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3113C24356
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 14:11:05 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58CAvG7012563
	for <alsa-devel@alsa-project.org>; Mon, 8 Jun 2009 07:11:03 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n58CAuea020588
	for <alsa-devel@alsa-project.org>; Mon, 8 Jun 2009 17:40:57 +0530 (IST)
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

I want to by-default enable the following mixer controls for my platform:

Analog Left Capture Route AUXL
Analog Right Capture Route AUXR

Right now, they both come disabled in the default configuration and I have to enable them explicitly by issuing the amixer cset command. How can I do that automatically?

Thanks and Regards,
Anuj Aggarwal
