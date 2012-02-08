From: Patrick Lai <plai@codeaurora.org>
Subject: Multiple channels mapping
Date: Tue, 07 Feb 2012 17:02:00 -0800
Message-ID: <4F31C988.3090201@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 712F8103842
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 02:02:21 +0100 (CET)
Received: from [10.64.14.94] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 496BB10004D1
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 17:02:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The DSP I am working on supports channel assignments similar to ALSA
route plug-in described in this link http://drona.csa.iisc.ernet.in
/~uday/alsamch.shtml.
I am currently looking a way to pass channel/speaker mapping
information of PCM stream( i.c channel 0 -> Front Left speaker, channel
1 -> Front Right speaker) to ALSA driver. I looked at latest kernel
tree and don't think there is already provision for my purpose. Can
anyone confirm? If I were to improvise a way to pass channel/speaker
mapping information, should I follow the same approach similar to how
bits per sample and other hardware parameter is passed?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
