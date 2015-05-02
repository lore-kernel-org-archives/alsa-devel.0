From: =?utf-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>
Subject: Front speakers doesn't work in multichannel output,
	regression in ALC888
Date: Sat, 02 May 2015 07:42:27 +0200
Message-ID: <2927807.UsnFnTlWVL@luklap.workgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id D2416261721
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2015 07:42:30 +0200 (CEST)
Received: by lbbqq2 with SMTP id qq2so75784308lbb.3
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2015 22:42:30 -0700 (PDT)
Received: from luklap.workgroup (c162-131.icpnet.pl. [85.221.162.131])
 by mx.google.com with ESMTPSA id ra7sm1788701lbb.27.2015.05.01.22.42.29
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 May 2015 22:42:29 -0700 (PDT)
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

Hi all,

My problem is that when I set channel output to "Analog output surround 5.1" 
(or 2.1 or 4.1), I hear no sound in front speakers, but in case of 5.1 or 4.1 
I can hear sound in rear speakers. I use kernel 3.19.5 and it didn't happen in 
earlier kernels that is 3.18 and in 3.17 for sure.

My configuration is:
OS: Fedora 21 64 bit
SoundCard: ALC888
Model name: acer-aspire-4930g
Laptop: Acer Aspire 5930g
Speakers: external 5.1 with 3 jacks
Sound channel configuration module is standard configuration module from KDE.

Additional info:
1) When channel output is 5.1 and I unplug green jack and leave two others 
jacks connected then I can hear sound in laptop internal speakers.
2) Earlier (kernel 3.18 and 3.17) I didn't have possibility to choose 2.1 
configuration and additionally to 4.1 configuration I could also choose 4.0 
configuration.

Thanks for looking into problem.

Cheers
LW
