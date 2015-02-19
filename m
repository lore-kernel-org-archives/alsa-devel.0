From: Xuebing Wang <xbing6@gmail.com>
Subject: About iMX6SL AUDMUX (port 7) and SSI3
Date: Thu, 19 Feb 2015 18:57:39 +0800
Message-ID: <54E5C1A3.8020301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB5C260547
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 11:57:45 +0100 (CET)
Received: by mail-ig0-f169.google.com with SMTP id hl2so2032343igb.0
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 02:57:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: nicolin Chen <nicoleotsuka@gmail.com>, niranjan Patil <Niranjan.Patil@infocus.com>, timur Tabi <timur@tabi.org>, richard Jiang <Richard.Jiang@infocus.com>, xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi community:

I am working on ASoC based sound driver for our iMX6SL based board. 
There are 3 I2S peripherals on the board:
- iMX6SL pads AUD3 (as in AUD3_TXC), connect to peripheral Codec3
- iMX6SL pads AUD5 connect to Codec5
- iMX6SL pads Aud6, connect to Codec6

Q1) Is internal SSI3 controller (ssi@02030000) actually *hard-wired* to 
AUDMUX port 7?

Q2) Can I configure audmux as below?
- External AUD3 -> internal SSI3 (which is actually audmux port 7?)
- External AUD5 -> internal SSI2 (ssi@0202c000)
- External AUD6 -> internal SSI1 (ssi@02028000)

Thanks.

-- 
Xuebing
