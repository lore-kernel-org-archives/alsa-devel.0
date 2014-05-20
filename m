From: Petr Kulhavy <petr@barix.com>
Subject: ASoC: Two codecs on a single CPU DAI
Date: Tue, 20 May 2014 15:08:25 +0200
Message-ID: <537B53C9.6000900@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B37B0261AE4
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 15:08:27 +0200 (CEST)
Received: by mail-ee0-f50.google.com with SMTP id e51so582526eek.9
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 06:08:27 -0700 (PDT)
Received: from [192.168.11.22] (84-72-111-243.dclient.hispeed.ch.
 [84.72.111.243])
 by mx.google.com with ESMTPSA id t7sm3780209eel.16.2014.05.20.06.08.25
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 20 May 2014 06:08:26 -0700 (PDT)
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

I'm writing a driver for a custom DaVinci board, which has two codecs 
(Wolfson and STA323 amplifier) connected to the same CPU DAI. The 
intention is that both codecs always play the same audio, only the 
volume/mixer settings are controlled separately. In addition to that the 
design is atypical by the fact, that the Wolfson is the clock master. So 
in order to play audio on the amplifier the Wolfson must be initialized 
as well.

My question is: how to reflect this architecture in a SOC platform driver?

As the first approach I tried to create two DAI links, one for each 
codec. That worked if audio was first played on the Wolfson link (clock 
master was initialized) and then on the second link, using the same 
sampling rate.

But in fact I would need only one DAI link to both. So then I tried to 
make just one link to Wolfson and put the amplifier as an "aux_dev". 
However there I need to set hw_params and format for the amplifier codec 
DAI and those functions were not called. In fact there was no codec DAI 
created for the amplifier. I've also seen that one can define rtd_aux 
runtimes, but have nowhere found how to use it.

Could someone please help me?

Thanks a lot
Petr


-- 
Petr Kulhavy, MSc
System Architect
BARIX AG
