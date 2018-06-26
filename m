From: slava <slavak61@gmail.com>
Subject: dsd formats in ALSA plugins
Date: Wed, 27 Jun 2018 01:58:12 +0300
Message-ID: <c10509e5-101c-c7a7-8457-a4257753f1c6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8A12676F1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 00:58:15 +0200 (CEST)
Received: by mail-lf0-f45.google.com with SMTP id g21-v6so68246lfb.4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 15:58:15 -0700 (PDT)
Received: from [192.168.5.100] (ip-109-254-78-40.eq.dec.net.ua.
 [109.254.78.40])
 by smtp.gmail.com with ESMTPSA id v186-v6sm541568lfa.11.2018.06.26.15.58.13
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Jun 2018 15:58:13 -0700 (PDT)
Content-Language: ru
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

Hello.
I'm writing plugin with external filter plugin SDK,
they make some manipulation on received samples.
But i can't use dsd formats.
As i understand, they not allowed in all plugins (extplug, ioplug and 
internal alsa-lib)?
params_any + params_test_format(... dsd_u32_le) = error -22
Is this a ALSA lib restriction or i do something wrong

Thanks
