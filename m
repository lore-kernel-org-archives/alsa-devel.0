From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: reconfigure cpu dai after resume from suspend
Date: Fri, 4 Sep 2015 19:05:18 +0530
Message-ID: <CANv6ZMY2_kk-FZ+J7XOwk0XPHY5STNDpLK1Sir+RHG=wSvYt_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id D035C26064C
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2015 15:35:20 +0200 (CEST)
Received: by qgev79 with SMTP id v79so15737432qge.0
 for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2015 06:35:19 -0700 (PDT)
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

I came across a situation, where I need to reconfigure cpu dai (
similar to cpu dai's hw_params())
after system resumed from suspend. Should this be taken care by soc
core or do I need to call
the same logic(hw_params()) inside snd_soc_dai_driver's  resume() ?

Regards,
Maruthi
