From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: [snd_ali5451] snd_ali5451 0000:00:06.0: BUG: ,
 pos = 16384, buffer size = 16384, period size = 1024
Date: Sun, 24 Apr 2016 18:43:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.1604241839520.8643@localhost.localdomain>
References: <alpine.LNX.2.20.1604222124360.12418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E71F2604D6
 for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2016 18:43:19 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id e201so16434603wme.2
 for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2016 09:43:19 -0700 (PDT)
Received: from metropolis (host65-30-dynamic.0-87-r.retail.telecomitalia.it.
 [87.0.30.65])
 by smtp.gmail.com with ESMTPSA id d131sm14563771wmd.12.2016.04.24.09.43.17
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Apr 2016 09:43:18 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.20.1604222124360.12418@localhost.localdomain>
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

After using the system for some time, the following is present on my dmesg:
$ dmesg -t | grep -i ali5 | sort | uniq

pnp 00:06: Plug and Play ACPI device, IDs ALI5123 PNP0510 (active)
snd_ali5451 0000:00:06.0: AC'97 1 access is not valid [0xffffffff], removing mixer.
snd_ali5451 0000:00:06.0: AC'97 1 does not respond - RESET
snd_ali5451 0000:00:06.0: ali mixer 1 creating error.
snd_ali5451 0000:00:06.0: enabling device (0005 -> 0007)
snd_ali5451 0000:00:06.0: invalid position: , pos = 16384, buffer size = 16384, period size = 1024
snd_ali5451 0000:00:06.0: invalid position: , pos = 16385, buffer size = 16384, period size = 1024

Thank you very much,
Enrico
