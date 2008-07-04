From: dinesh <dinesh.dua@coraltele.com>
Subject: Using BD in place of DMA in soc driver
Date: Fri, 04 Jul 2008 17:41:58 +0530
Message-ID: <1215173518.16282.19.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	by alsa0.perex.cz (Postfix) with ESMTP id B49BA249E8
	for <Alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 14:13:49 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.coraltele.com (Postfix) with ESMTP id 607FE1B267C
	for <Alsa-devel@alsa-project.org>; Fri,  4 Jul 2008 17:43:43 +0530 (IST)
Received: from mail.coraltele.com ([127.0.0.1])
	by localhost (mail.coraltele.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3kbNs5QryVX for <Alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 17:43:41 +0530 (IST)
Received: from [192.168.4.53] (unknown [192.168.4.53])
	by mail.coraltele.com (Postfix) with ESMTPA id 23AA91B2676
	for <Alsa-devel@alsa-project.org>; Fri,  4 Jul 2008 17:43:41 +0530 (IST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi i want to use mpc8323 ucc tdm as sound soc device but i dont know how
to configure its buffer descriptor because every soc device available
uses DMA. Please help. 
