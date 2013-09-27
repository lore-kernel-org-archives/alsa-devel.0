From: Meelis Roos <mroos@linux.ee>
Subject: Re: usb-audio mic problem with Polycom C100S
Date: Fri, 27 Sep 2013 16:10:59 +0300 (EEST)
Message-ID: <alpine.SOC.1.00.1309271608540.1451@math.ut.ee>
References: <alpine.SOC.1.00.1309251653350.17530@math.ut.ee>
 <52458079.3090809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
 by alsa0.perex.cz (Postfix) with ESMTP id EA97A265713
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 15:10:59 +0200 (CEST)
In-Reply-To: <52458079.3090809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > I tried to use Skype (4.1) with Polycom Communicator C100S. Audio
> > output works fine but mic seems to be dead, although it is set to
> > capture and volume is even max.
> 
> Please show the output of "amixer scontents" for this device.

Simple mixer control 'PCM',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 61
  Mono: Playback 20 [33%] [-20.17dB] [on]
Simple mixer control 'Mic',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 64
  Mono: Capture 0 [0%] [0.00dB] [on]

-- 
Meelis Roos (mroos@linux.ee)
