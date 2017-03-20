From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: snd_hda_intel: probe of 0000:00:01.1 failed with error
	-2
Date: Mon, 20 Mar 2017 14:46:50 +0000
Message-ID: <AM2PR07MB1027FF6CDC0BA4C957ED22ACA13A0@AM2PR07MB1027.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00123.outbound.protection.outlook.com [40.107.0.123])
 by alsa0.perex.cz (Postfix) with ESMTP id A1CF8266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 15:46:53 +0100 (CET)
Content-Language: es-ES
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all!


I've a system with a custom distribution and a 3.16.7 linux kernel. Sometimes when the sound system is initialized I get this error and the sound is not working. I see in dmesg


[   36.104413] snd_hda_intel 0000:00:01.1: irq 80 for MSI/MSI-X
[   36.111812] sound hdaudioC1D0: autoconfig: line_outs=1 (0xa/0x0/0x0/0x0/0x0) type:line
[   36.111815] sound hdaudioC1D0:    speaker_outs=1 (0xb/0x0/0x0/0x0/0x0)
[   36.111817] sound hdaudioC1D0:    hp_outs=1 (0x9/0x0/0x0/0x0/0x0)
[   36.111819] sound hdaudioC1D0:    mono: mono_out=0x0
[   36.111820] sound hdaudioC1D0:    dig-out=0x10/0x15
[   36.111821] sound hdaudioC1D0:    inputs:
[   36.111823] sound hdaudioC1D0:      Mic=0xd
[   36.111824] sound hdaudioC1D0:      Line=0xc
[   36.111826] sound hdaudioC1D0:    dig-in=0x12
[   36.115940] sound hdaudioC0D0: ignore pin 0x7, too many assigned pins
[   36.115942] sound hdaudioC0D0: autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
[   36.115944] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   36.115945] sound hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   36.115946] sound hdaudioC0D0:    mono: mono_out=0x0
[   36.115947] sound hdaudioC0D0:    dig-out=0x3/0x5
[   36.115948] sound hdaudioC0D0:    inputs:
[   37.119900] snd_hda_intel: probe of 0000:00:01.1 failed with error -2
[   37.127608] sound hdaudioC0D0: autoconfig: line_outs=1 (0xa/0x0/0x0/0x0/0x0) type:line
[   37.127613] sound hdaudioC0D0:    speaker_outs=1 (0xb/0x0/0x0/0x0/0x0)
[   37.127615] sound hdaudioC0D0:    hp_outs=1 (0x9/0x0/0x0/0x0/0x0)
[   37.127617] sound hdaudioC0D0:    mono: mono_out=0x0
[   37.127618] sound hdaudioC0D0:    dig-out=0x10/0x15
[   37.127620] sound hdaudioC0D0:    inputs:
[   37.127622] sound hdaudioC0D0:      Mic=0xd
[   37.127624] sound hdaudioC0D0:      Line=0xc
[   37.127625] sound hdaudioC0D0:    dig-in=0x12



and


# cat /proc/asound/cards
 0 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xff760000 irq 39


What's the meaning of this error?

Regards,
Jorge
