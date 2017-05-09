From: ojab <ojab@ojab.ru>
Subject: `alsatplg` miscompiles UUID in ASoC topology
Date: Tue, 9 May 2017 19:32:03 +0000
Message-ID: <a4e761b7-420c-47e4-dd01-15becdbdb3ab@ojab.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 12F09266872
 for <alsa-devel@alsa-project.org>; Tue,  9 May 2017 21:32:07 +0200 (CEST)
Received: by mail-lf0-f42.google.com with SMTP id h4so8155335lfj.3
 for <alsa-devel@alsa-project.org>; Tue, 09 May 2017 12:32:07 -0700 (PDT)
Received: from localhost.localdomain ([195.91.239.8])
 by smtp.gmail.com with ESMTPSA id h13sm152810ljh.5.2017.05.09.12.32.05
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 May 2017 12:32:06 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oh hai!

I'm trying to get sound from my HP Chromebook 13 with proper linux and 
right now messing with ASoC topology: ChromeOS contains topology file 
that can't be loaded on up-to-date upstream kernel, so I've wrote a 
parser that converts dfw_sst.bin back to topology.conf that can be 
processed by `alsatplg`.

AFAICS alsatplg miscompiles at least UUID field in the private data: for 
example `alsatplg -c /usr/share/alsa/topology/sklrt286/skl_i2s.conf -o 
tplg.bin` produces the file with no UUID in `strings tplg.bin` output 
and my parser shows that there is nonsense (mostly zeroes) where UUID 
should be (reproducible with both alsa-{lib,utils}-1.13 and current git 
master).

Is it a bug or I'm doing something wrong?

-- 
//wbr ojab
