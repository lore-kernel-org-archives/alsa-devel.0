From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REPLACE,
 ... not working from userspace ?
Date: Mon, 3 Jul 2017 16:02:54 +0200
Message-ID: <c7599ba3-f6c3-bb46-c08d-efff67ca60e9@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 11BAB266F15
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 16:02:56 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id i127so109792953wma.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Jul 2017 07:02:56 -0700 (PDT)
Received: from [10.20.101.100] (sne56-1-88-180-128-218.fbx.proxad.net.
 [88.180.128.218])
 by smtp.googlemail.com with ESMTPSA id y53sm5096915edb.62.2017.07.03.07.02.54
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Jul 2017 07:02:55 -0700 (PDT)
Content-Language: en-GB
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
List-Id: alsa-devel@alsa-project.org

Hi,

I try to rename existing sound control from userspace. The goal is to 
create a generic abstraction layer for AutomotiveGradeLinux audio server

While I found two hidden methods to access to low level functionalities 
from user space, non of them seems to accecp replace call.

I isolated the code in two basic samples 
https://github.com/fulup-bzh/alsa-ctl-replace

  - First one uses a directt IOTCL model

  - Second one leverage private sndctl control handle.

Any idea would be more than welcome.

Fulup
