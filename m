From: Patrick Lai <plai@codeaurora.org>
Subject: Query about  SNDRV_PCM_FORMAT_S24_LE
Date: Thu, 28 Feb 2013 00:08:46 -0800
Message-ID: <512F108E.20904@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 49DA7265B88
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 09:08:49 +0100 (CET)
Received: from [10.64.143.81] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
 by mostmsg01.qualcomm.com (Postfix) with ESMTPA id D96C010004B1
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 00:08:46 -0800 (PST)
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

The DSP I am working with currently supports 24-bit PCM sample in
32-bit data space but with LSB padded. Based on the discussion I found
on line, SNDRV_PCM_FORMAT_S24_LE is defined to be 24-bit PCM sample in
32-bit data space with MSB padded. Also, there is no format macro
defined for the format which my DSP supports. Please correct me if I am
wrong. Furthermore, which software layer in audio stack of a typical
linux distribution such as ubuntu handles the padding. I don't think
it's handled by the alsa library. Does application or pulseaudio handle
the padding? I would think it's done in pulseaudio. I have not study
pulseaudio codec extensively but would think someone on the mailing
list can give a quick answer.

Thanks
Patrick
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
