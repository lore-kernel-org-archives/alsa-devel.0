From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: alsa error
Date: Tue, 7 Jul 2015 08:29:05 +0000
Message-ID: <SIXPR04MB253D7F0F7321A5BC79B1233C3920@SIXPR04MB253.apcprd04.prod.outlook.com>
References: <SIXPR04MB253D88AF361F3A2E8368EE6C3920@SIXPR04MB253.apcprd04.prod.outlook.com>,
 <559B7C5D.50401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on0129.outbound.protection.outlook.com [104.47.124.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 22AE2261A95
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 10:29:11 +0200 (CEST)
In-Reply-To: <559B7C5D.50401@ladisch.de>
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

Dear Clemens

Thanks a lot for your quick responses

Do you mean Codec driver??

Could you please provide me the links ie., code flow how this alsa frameworks interacts with codec driver

Thanks in advance

________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Tuesday, July 7, 2015 12:44 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] alsa error

Srinivasan S wrote:
> Am facing the below error, could you please let me know what could be the issue leading to this error
>
> Feb 11 18:48:22 kernel: [  210.508525] ALSA sound/core/pcm_native.c:2080 snd_pcm_hw_constraints_complete failed

A bug in your driver.


Regards,
Clemens
