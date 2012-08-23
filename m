From: "Rafal Powierski" <powierski@mediascore.de>
Subject: multistream singlechanel DACs
Date: Thu, 23 Aug 2012 19:10:23 +0200
Message-ID: <212966EEC07D4CAE9753E9DA50F80AF7@mediascore.mediascore.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 24D2C265CED
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 19:10:24 +0200 (CEST)
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

Developers,

how to enable multiple playback streaming?:

I am manipulating bios verb pin table, for special analog hardware, using 
ALC886 and kubuntu / 64bit.

I need a number of separate stereo (only stereo) i/o's
I have correctly configured inputs:
4. single stereo adc port-C 1Ah
5. single spdif input 1Fh
I have configured 3 independent stereo outputs, but ALSA is joining them 
into one pcmC1D0p device.
1.port-A,15h
2.port-E,1Bh
3.port-D,14h
I have tried this on win7 and I got all associations as a separate devices.
in my kubuntu 12.4LTS I have only one playback device.
Mixer is showing even more then needed number of volume controls,
But there is only one playback device.
it seams, all 3 outputs are connected to single DAC.
I have tried to buildup more input devices - this is working good.
I can have up to 3 (pcmC1D0c, pcmC1D1c pcmC1D2c)
I can also have 2 outputs if I enable spdif-out.
But there is no separate DAC assignment  to separate devices resulting from
my  config.

Is it possible to get independent DACs devices under ALSA?
or else is no such configuration possible and I have to use single multiple 
channel device?
