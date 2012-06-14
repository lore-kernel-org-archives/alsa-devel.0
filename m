From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Does amixer have commands to turn on / off Codec
 TWL4030 analog microphone bias voltage output?
Date: Thu, 14 Jun 2012 00:03:05 -0500
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE04A69EE073@edprex01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (smtp.logicpd.com [174.46.170.145])
	by alsa0.perex.cz (Postfix) with SMTP id DDED6244B4
	for <Alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 07:03:10 +0200 (CEST)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id EBei2wrv13EZASDY
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<Alsa-devel@alsa-project.org>; Thu, 14 Jun 2012 00:03:08 -0500 (CDT)
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
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am using Linux kernel 3.0 and a  Logic PD DM3530 SOM LV, looking for the amixer commands to turn on / off analog microphone bias supply.
Following lines do not have the bias needed for Headset MIC input:

amixer set 'Analog Left AUXL' nocap
amixer set 'Analog Right AUXR' nocap
amixer set 'Analog Left Main Mic' nocap
amixer set 'Analog Left Headset Mic' cap

Anybody can help?

Thanks,

Philip Chu

principal software engineer
LogicPD www.logicpd.com
5 Clock Tower Place, Suite 215
Maynard, MA 01754
Phone: 978-243-2450 Fax: 978-461-1598
