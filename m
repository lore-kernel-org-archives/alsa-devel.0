From: "Liu, George" <yueliu@lab126.com>
Subject: how to unload alsa kernel driver
Date: Tue, 17 Jul 2012 16:44:13 -0700
Message-ID: <164969DEADC6FB4E8F1494DA3D34E98B03462F0924@EX-SEA19-A.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.189.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 09017264FD3
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 01:44:19 +0200 (CEST)
Received: from ex-hub-9002.ant.amazon.com (ex-hub-9002.sea19.amazon.com
 [10.185.11.25])
 by smtp-in-0105.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id q6HNiFed012283
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 23:44:16 GMT
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

I'm new to kernel development and is trying out the dummy alsa driver.
I can compile and install snd_dummy driver on my Ubuntu, but how do I remove it?

It seems that after installation, snd_pcm and snd automatically depends on snd_dummy, so rmmod will not work.

Alsa force-unload snd-dummy also not work.
Can somebody help? I don't want to restart my machine every time.

Thanks
George
