From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 14/16] ALSA: Oxygen: Remove code from
 the	xonar_dg.c file
Date: Sat, 18 Jan 2014 12:08:34 +0100
Message-ID: <52DA60B2.7070703@ladisch.de>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
 <1389971315-3215-14-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 82A65261A12
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 12:08:47 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AE2A120AB0
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 06:08:45 -0500 (EST)
In-Reply-To: <1389971315-3215-14-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roman Volkov wrote:
> The mixer code and other system structures will come
> to the separate file.

>  sound/pci/oxygen/xonar_dg.c |  393 -------------------------------------------
>  1 file changed, 393 deletions(-)

This change breaks the driver; you need to merge patches 14..16.


Regards,
Clemens
