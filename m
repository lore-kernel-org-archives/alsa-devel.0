From: Patrick Lai <plai@codeaurora.org>
Subject: ucm: hardware resource arbitration
Date: Mon, 10 Sep 2012 23:49:51 -0700
Message-ID: <504EDF0F.70809@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 11F10260311
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 08:50:05 +0200 (CEST)
Received: from [10.64.136.183] (pdmz-ns-snip_218_1.qualcomm.com
 [192.168.218.1])
 by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 127DB10004AA
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 23:50:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have two use cases which can acquire same CODEC path but they cannot
run concurrently through mixing. When such scenario does arise,
arbitration is required based on priority of use cases. On the other
hand, same use cases on different platform may use different CODEC
paths so arbitration is not required. In order to decide whether
arbitration is required, I think the best place to do so is in UCM. I
looked at existing UCM APIs but I do not believe existing APIs have
concept of arbitration built in. If I am wrong, how can I handle
arbitration with existing UCM APIs. If I am correct, is there anyone
looking to expand UCM APIs for similar scenario?

Thanks
Patrick
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
