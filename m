From: =?ISO-8859-15?Q?Ulrich_G=FCnther?= <ulrich.guenther@gmx.at>
Subject: Alsa USB Audio regression
Date: Sun, 14 Jul 2013 15:45:40 +0200
Message-ID: <51E2AB84.9070603@gmx.at>
References: <51E2AA11.8090500@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A01B264FBB
 for <alsa-devel@alsa-project.org>; Sun, 14 Jul 2013 15:45:43 +0200 (CEST)
Received: from [192.168.1.100] ([178.112.135.254]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LtlG5-1U02hn3q8z-011B9F for
 <alsa-devel@alsa-project.org>; Sun, 14 Jul 2013 15:45:43 +0200
In-Reply-To: <51E2AA11.8090500@gmx.at>
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

Hello, i encounterd a possible alsa bug with the "ID 0d8c:0006 C-Media
Electronics, Inc. Storm HP-USB500 5.1 Headset".

After Ubuntu 10.04 LTS (Ubuntu 10.10 works, Ubuntu 11.04 doesn't work at
all, Ubuntu 11.10 and newer have the bug), the headset only plays sound
at maximum volume level if the volume is turned down just a little no
sound is being played.

I have filled a Ubuntu bug for 12.04 LTS at:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1200925 .
I was advised to contact this mailing list.

AlsaInfo for Ubuntu 12.04 LTS with the bug:
http://www.alsa-project.org/db/?f=3bde76b15a15f585418a6a4a4703ca67fd4cdf42 .
AlsaInfo for Ubuntu 10.04 LTS without the bug:
http://www.alsa-project.org/db/?f=5824e55345c3f7128937405254485a489886b9dc .

Thank You for your help.
