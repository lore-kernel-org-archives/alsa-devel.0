From: Prasant J <pj0585@gmail.com>
Subject: Non-Interleaved access method?
Date: Thu, 18 Oct 2012 17:46:31 +0530
Message-ID: <CAA2DH4uV6qzzJzpbZx6-MXnH4SBD11uqDkaxHnOTesvCXabM4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E3CB2652E1
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 14:16:32 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so1304010qao.17
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 05:16:31 -0700 (PDT)
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


When the application set the access method to non-interleaved, that
means that the ALSA application will deliver the non-interleaved
buffers to alsa subsystem & the alsa subsystem will interleave the
data before sending out the data to the hardware.
Am I correct?

Or non-interleaved means that the data will be sent out in
non-interleaved manner itself?


Regards,
-Prasant
