From: Tobias Eklund <tobias.h.e.eklund@gmail.com>
Subject: bug report. Envy24 based card (terratec ews88d) won't
 slave to external clock via s/pdif.
Date: Thu, 2 Aug 2018 22:03:21 +0200
Message-ID: <CAFO8paF9fKtf1RNNK9iaUheto7Orx1VyBsVqA_dWoM3qbpoeZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6382677D9
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 22:03:22 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id u24-v6so1904276pfn.13
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2018 13:03:22 -0700 (PDT)
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

Hi,

when trying to clock my terratec ews88d from an apogee rosetta AD it just
won't. The s/pdif input works but the card won't lock to the s/pdif clock
but rather stay at whatever setting it was at before i change to s/pdif in
envy24control or mudita24.

Since I have another converter slaved via ADAT out I can tell what sample
rate is being output via ADAT sync. Works perfectly for setting the sample
rate in envy24control but not when i choose external clock and change the
rate on the Apogee AD. Also, audio recorded through the s/pdif input is
obviously at the wrong rate when changing the rate on the Apogee AD.

I found this old discussion which seems to describe the same problem:
http://alsa-devel.alsa-project.narkive.com/30mvygRD/m-audio-delta-1010lt-s-pdif-clock-source-not-working

Also, there is a problem with the alsa-info.sh script, it didn't give me
url to share. Just the message Your ALSA information is located at
Please inform the person helping you.
If the alsa-info.sh output is required i'll post it in an e-mail.

kind regards,
-- 
Tobias Eklund
Fatburs Brunnsgata 31
118 28 Stockholm
0046 707570196
