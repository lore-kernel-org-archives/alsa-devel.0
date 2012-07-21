From: "Liu, George" <yueliu@lab126.com>
Subject: virtual sound driver
Date: Fri, 20 Jul 2012 18:05:40 -0700
Message-ID: <164969DEADC6FB4E8F1494DA3D34E98B034641ADAB@EX-SEA19-A.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-fw-9101.amazon.com (smtp-fw-9101.amazon.com
 [207.171.184.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B68BA265B43
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 03:06:18 +0200 (CEST)
Received: from ex-hub-31012.ant.amazon.com (ex-hub-31012.sea31.amazon.com
 [10.185.169.29])
 by smtp-in-6001.iad6.amazon.com (8.13.8/8.13.8) with ESMTP id q6L15qmw030276
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 01:05:55 GMT
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm trying to write a virtual sound driver to capture PCM data.
How do I modify dummy.c to capture PCM into buffer?

Does the PCM data ever sent to any of the pcm_op call backs? There's no read/write callbacks?

Thanks so much.

George
