From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: eeprom params for ice1724 module - recommendation?
Date: Wed, 04 Jan 2012 21:37:46 +0100
Message-ID: <4F04B89A.1060801@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 94E2124409
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:38:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 5DBDEA1A40B20
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:38:07 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRpviS0df83Q for <alsa-devel@alsa-project.org>;
	Wed,  4 Jan 2012 21:37:52 +0100 (CET)
Received: from [192.168.105.101] (ip28.insite.cz [81.0.237.28])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 892D8A1A32346
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 21:37:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a generic ice1724 card ooAoo SQ210a (e.g.
http://forum.lowyat.net/topic/851912/all ). The card has identical PCI
identification with Chaintec AV710, no DAC controls (the DAC is
hardwired in pin-control mode with no GPIOs attached), no identification
string in eeprom and of course incorrect eeprom values.

Since the PCI ids overlap with the Chaintec, I cannot define correct
eeprom_data for this specific card in the driver. Furthermore I would
not be surprised if the other ooAoo cards with different setups shared
the same PCI ids.

I can skip the Chaintec config by specifying an unknown model in
snd-ice1724 param, e.g.

modprobe snd-ice1724 model=aooa

I would like to be able to specify correct eeprom values for the model
too. That would be simple by adding several new module params -
eeep2-sysconf, eeep2-aclink, eeep2-spdif etc.

However, I have another ice1724 card properly supported by the driver
(Infrasonic Quartet). I can use

modprobe snd-ice1724 model=quartet,aooa

and everything works correctly. But if I wanted to define eeep2-xxx
params for the aooa, I would have to define the same params for the
quartet too which I find superfluous since they are already correctly in
the driver.

Or I could use a string type instead of int and use something like

eeep2-sysconf=default,47

Or I could "encode" the eeep2 params into the model name, such as

modprobe snd-ice1724 model="quartet,aooa(eeep2-sysconf=47;eeep2-spdif=20)"

Please which version would you recommend (i.e. accept as a patch)?

Thank you for your expert advice.

Best regards,

Pavel.
