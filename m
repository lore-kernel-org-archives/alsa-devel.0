From: Brian Clarkson <clarkson@orthogonaldevices.com>
Subject: audio-over-SPI driver for ASoC
Date: Fri, 9 Oct 2015 23:29:40 +0900
Message-ID: <5617CF54.7090508@orthogonaldevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id DF4B92606E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 16:29:55 +0200 (CEST)
Received: by padhy16 with SMTP id hy16so88332817pad.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Oct 2015 07:29:54 -0700 (PDT)
Received: from [192.168.1.103] (KD106177208232.ppp-bb.dion.ne.jp.
 [106.177.208.232])
 by smtp.gmail.com with ESMTPSA id xd10sm2833154pab.25.2015.10.09.07.29.53
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Oct 2015 07:29:53 -0700 (PDT)
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

Hi

I'm about to embark on the development of an ASoC capture driver that 
uses SPI to stream the samples to the processor.  I'm still spending a 
lot of my time going through the ALSA kernel code but as I do that may I 
have some suggestions as to which examples would be closest to my case?  
My development hardware is AM335x --> McSPI --> ADS8868.

So far I think I have achieved a solid understanding of the 
"simple-card" case where you have dai-link that connects a processor 
peripheral driver (e.g. McASP ) with a codec driver and forms a 
snd_soc_card that can be registered.  Is my best option to:

- write a new CPU DAI (snd_soc_dai_driver) based on the existing SPI driver
- write a new CODEC DAI (snd_soc_dai_driver) which will be mostly empty
- write a new platform driver that populates and registers a new 
snd_soc_card struct with the above in a dai_link?

Any advice would be much appreciated.

Cheers,
Brian

-- 
Orthogonal Devices
Tokyo, Japan
www.orthogonaldevices.com
+81 80 8700 2340
