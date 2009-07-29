From: "Christian Steffen" <c-steffen@web.de>
Subject: clicking noise with Sigmatel STAC9202
Date: Wed, 29 Jul 2009 15:06:02 +0200
Message-ID: <000501ca104d$533e2bb0$f9ba8310$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 3839F103884
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 15:06:04 +0200 (CEST)
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 12AB710EAEFBC
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 15:06:03 +0200 (CEST)
Received: from [92.228.211.91] (helo=Crusoe)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277) id 1MW8r4-0005hU-00
	for alsa-devel@alsa-project.org; Wed, 29 Jul 2009 15:06:02 +0200
Content-Language: de
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello to all subscribers,


I'm new to this list and will start directly with my problem:

I'm running some ubuntu linux on a device called "o2 Joggler", which is a
digital picture frame with touchscreen control.
Its chipsets are from intel, the cpu is an intel atom, and the other
hardware devices are controlled by an Intel System Controller Hub "Poulsbo".

I'm running kernel 2.6.30 and the newest alsa version 1.0.20.

This is lscpi output:
>>00:1b.0 Audio Device: Intel Corporation System Controller Hub (SCH
Poulsbo) HD Audio Controller (rev 07)

cat proc/asound/cards:
>>0 [MID     ]: HDA-Intel - HDA Intel MID
>>              HDA Intel MID at 0xd01c000 irq 16

The Codec is a
>>Sigmatel STAC9202


My problem is, that sound is working, but has constant clicking noise in the
background, also if the sound is completely muted.
First I thought this sound would come from some hdd or whatever, but the
device has no mechanical parts. But this is what it sounds like - Irregular
clicking noise.

This noise immediately starts during boot up as soon as the module is loaded
and before X11 has started.
I already tried options like "position_fix=1 or 2" and different
"model="-options with no success.
"position_fix" didn't do anything at all and different model-options have
muted the device completely.


Has someone any idea to get this working?
The device comes with an own (hardly) closed linux which runs a 2.6.24
kernel - here sound is working with no problems at all.

If you need further info, let me know.


Thanks in advance, best!
Christian 
