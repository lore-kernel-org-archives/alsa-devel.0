From: =?UTF-8?Q?Micha=c5=82_Wadowski?= <wadosm@gmail.com>
Subject: Fix for Lenovo B50-70 inverted internal microphone bug
Date: Fri, 10 May 2019 23:52:21 +0200
Message-ID: <abb4a724-b561-9579-e821-b56ff00051c5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C77EDF80730
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 23:52:24 +0200 (CEST)
Received: by mail-lf1-x12e.google.com with SMTP id j20so5163794lfh.2
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 14:52:24 -0700 (PDT)
Received: from [192.168.0.94] (31-178-116-31.dynamic.chello.pl.
 [31.178.116.31])
 by smtp.googlemail.com with ESMTPSA id y186sm1991324lfa.14.2019.05.10.14.52.22
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 May 2019 14:52:22 -0700 (PDT)
Content-Language: pl-PL
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I prepared patch for this bug:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1524215

I tested this patch on Linux 5.1.0 and it fixes problem on my Lenovo 
B50-70 laptop.
