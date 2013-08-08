From: Joonas Saarinen <jonskunator@gmail.com>
Subject: LG LW25 pin fix
Date: Thu, 08 Aug 2013 22:46:47 +0300
Message-ID: <5203F5A7.5010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A74F2610CF
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 21:46:49 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so1157146bkb.17
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2013 12:46:48 -0700 (PDT)
Received: from [172.20.0.36] (dsl-espbrasgw1-50dfb6-224.dhcp.inet.fi.
 [80.223.182.224])
 by mx.google.com with ESMTPSA id cb7sm2931126bkb.16.2013.08.08.12.46.47
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 08 Aug 2013 12:46:48 -0700 (PDT)
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

Hello, I discovered that the LG LW25 laptop needs a small fix to its pin 
mapping. The functions of blue and green jacks simply have to be 
interchanged. The rest of the configuration is correct. Can this fix be 
made permanent in the driver?

The fixed mappings are:

0x1a 0x0181344f
0x1b 0x0321403f

Here's the full correct map:

[codec]
0x10ec0880 0x00001854 0

[pincfg]
0x14 0xb7031110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x01a19c22
0x19 0xb7a31120
0x1a 0x0181344f
0x1b 0x0321403f
0x1c 0x411111f0
0x1d 0x411111f0
0x1e 0x0145311e
0x1f 0x411111f0


Thanks,
Joonas
