From: Fabio Estevam <festevam@gmail.com>
Subject: Testing SAI with mainline
Date: Mon, 7 Mar 2016 17:44:08 -0300
Message-ID: <CAOMZO5DnC7NGd1+QPzeaVQ0GMY_yxq3KZBQSAOoj+QKQ8W+HfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BF0726154F
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 21:44:09 +0100 (CET)
Received: by mail-ig0-f178.google.com with SMTP id ig19so34477625igb.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2016 12:44:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to get SAI to work on a mx6sx sdb board.

Here are the changes I made:
http://pastebin.com/aq32B24v

I can see the driver getting probed:

[    2.198276] fsl-asoc-card sound: wm8962 <-> 21d4000.sai mapping ok

,but when attempting a playback it fails:

$ aplay clarinet.wav
[  110.843619] fsl-sai 21d4000.sai: isr: Transmit underrun detected
[  110.849841] fsl-sai 21d4000.sai: isr: Transmit underrun detected
[  110.855995] fsl-sai 21d4000.sai: isr: Transmit underrun detected

(repeats forever).

Any ideas as to how to get SAI working on this platform?

Zidan,

How have you tested SAI when you usptream the driver?

Thanks
