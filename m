From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: MIDI port using UART interface
Date: Sat, 19 Sep 2015 15:35:16 +0200
Message-ID: <55FD6494.8030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E84F8260557
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 15:35:24 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so94344801wic.1
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 06:35:22 -0700 (PDT)
Received: from [192.168.56.2] ([5.90.142.170])
 by smtp.googlemail.com with ESMTPSA id kr10sm553487wjc.25.2015.09.19.06.35.21
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Sep 2015 06:35:21 -0700 (PDT)
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
I'm looking to use an UART interface as a MIDI in/out port.
Since MIDI is an asynchronous serial interface just like UART, and 
provided a given UART controller is able to operate at 31.25 kbps (in my 
case, it is) a UART port can be transformed into a MIDI port by adding 
some hardware components (e.g. an optocopuler) to it, I would have 
expected to find a generic MIDI<->UART adapter layer in the kernel that 
bridges the ALSA MIDI interface with UART drivers and allows to operate 
UARTs as MIDI ports. But apparently there is no such generic adapter, 
the closest driver I found is for the UART 16550 but this is specific to 
a type of UART controller different from the one in the platform I'm 
using (which is i.MX6).
So how would you approach the task of writing a MIDI driver that uses 
UART behind the scenes? Am I correct in assuming that I have to use the 
RawMIDI interface (as the UART 16550 driver does) to make my MIDI port 
available to ALSA applications? Or is there a better alternative?

Thanks,
Francesco
