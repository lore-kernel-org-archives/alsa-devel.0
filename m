From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Running PJSIP for voip calls in alsa
Date: Fri, 10 Jul 2015 12:33:50 +0000
Message-ID: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0117.outbound.protection.outlook.com [134.170.140.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 1244126043C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 14:33:54 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Clemens,


Could you please let me know whether the below issue is in PJSIP or alsa or driver or in the ti sdk8 BSP's (rootfs)

1. We are running PJSIP for establishing VOIP calls on ti sdk 8 BSP's (linux kernel 3.14), we are seeing the below error messages in the PJSIP, Could you please let me know what could be issue ?

08:32:42.082 Master/sound Underflow, buf_cnt=0, will generate 1 frame
08:32:42.083 Master/sound Underflow, buf_cnt=0, will generate 1 frame
08:32:42.086 Master/sound Underflow, buf_cnt=0, will generate 1 frame
08:32:42.088 Master/sound Underflow, buf_cnt=0, will generate 1 frame
08:32:42.088 Master/sound Underflow, buf_cnt=0, will generate 1 frame
08:32:42.091 Master/sound Underflow, buf_cnt=0, will generate 1 frame
08:32:42.112 Master/sound Underflow, buf_cnt=0, will generate 1 frame

In failure call pjsip reports Master/sound Underflow continuously, At this point the control stays at pjsip and application will wait for it and all functionality in idle state at application and after this, no other feature will work until restart the application.

The above problem observed with new rootfs (ti sdk 8) but when we tried with old rootfs (ti sdk 7) we are able to make calls with no problem. Few calls are long duration calls(33 and 55 minutes).

With ti sdk 8 kernel, I tried replacing even the alsa libraries from ti sdk 7 rootfs to ti sdk 8 rootfs, but still the issue persists,

/usr/lib/libasound.la

/usr/lib/libasound.so

/usr/lib/alsa-lib/smixer/smixer-ac97.la

/usr/lib/alsa-lib/smixer/smixer-ac97.so

/usr/lib/alsa-lib/smixer/smixer-hda.la

/usr/lib/alsa-lib/smixer/smixer-hda.so

/usr/lib/alsa-lib/smixer/smixer-sbase.la

/usr/lib/alsa-lib/smixer/smixer-sbase.so

Firstly could you please let me know why this issue is seen in ti sdk 8 BSP's (ie., in rootfs), & what could be the problem in ti sdk 8 rootfs ??
Apart from the above is there any other ALSA related configuration files, needs to copied from the ti sdk 7 rootfs to ti sdk 8 rootfs, inorder to resolve this issue

If possible, could you please validate this PJSIP version 2.3 on ti sdk 8 BSP's on your EVK kit & let me know whether this issue is reproducible

Awaiting for your replies,
Many Thanks in advance
