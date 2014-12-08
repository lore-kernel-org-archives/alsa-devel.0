From: thomas chen <tchen61@gmail.com>
Subject: I2S frame configuration
Date: Mon, 08 Dec 2014 10:37:46 -0500
Message-ID: <5485C5CA.8030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
 [209.85.216.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 43964260453
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:37:53 +0100 (CET)
Received: by mail-qc0-f173.google.com with SMTP id i17so3666859qcy.18
 for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2014 07:37:52 -0800 (PST)
Received: from [192.168.1.55] (pool-108-56-195-196.washdc.fios.verizon.net.
 [108.56.195.196])
 by mx.google.com with ESMTPSA id 34sm38035750qgt.19.2014.12.08.07.37.51
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 08 Dec 2014 07:37:51 -0800 (PST)
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

I am working on a ALSA interface to a particular codec over I2S

the audio stream format is a bit peculiar...  (CODEC being MASTER)

there are 24 BCLK cycle between transition of FSYNC...   howver, there 
are only 16 bit that are valid

bit 0: ignore
bit 1-16:   valid pcm data (MSB....LSB)
bit 17-23: ignore



Can anyone suggest how to configure the DAI format ???

Thanks
