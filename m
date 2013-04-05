From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: M-Audio Delta 1010LT: S/PDIF clock source not working
Date: Fri, 05 Apr 2013 17:34:40 +0200
Message-ID: <515EEF10.1020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C95F2265FFA
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 17:34:42 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jc3so2176653bkc.1
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 08:34:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to capture from S/PDIF. I get a signal but the clocking is 
broken somehow.

I have 'Multi Track Internal Clock' on 'ICE958 Input'.

'Word Clock Status' and 'Word Clock Sync' are 'Off'.

What happens is the following: It captures what comes in on S/PDIF but 
it seems it will always use the internal clock with the setting from 
'Multi Track Internal Clock Default'.

So even though 'Multi Track Internal Clock' is on 'ICE958 Input', the 
setting of 'Multi Track Internal Clock Default' will clock the signal.

A 1 kHz sine wave at 48 kHz samplerate captured with 'Multi Track 
Internal Clock Default' on 96 kHz will result in a 2 kHz sine. When the 
sample frequency rates are matched, it will capture at correct rate but 
with hiccups due to the rates not perfectly aligned.

What can I do narrow down the cause?

Reards
Jonas
