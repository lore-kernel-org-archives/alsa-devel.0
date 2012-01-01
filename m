From: Andrew <necromant@necromant.ath.cx>
Subject: [intel-hda] ALC663 question.
Date: Sun, 01 Jan 2012 21:30:38 +0400
Message-ID: <060957c544c2952d5be6283a582cc5a7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward5.mail.yandex.net (forward5.mail.yandex.net
	[77.88.46.21]) by alsa0.perex.cz (Postfix) with ESMTP id 697EC2440B
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2012 18:31:23 +0100 (CET)
Received: from smtp2.mail.yandex.net (smtp2.mail.yandex.net [77.88.46.102])
	by forward5.mail.yandex.net (Yandex) with ESMTP id 82F361200BA5
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2012 21:30:34 +0400 (MSK)
Received: from smtp2.mail.yandex.net (localhost [127.0.0.1])
	by smtp2.mail.yandex.net (Yandex) with ESMTP id 732B8E203A6
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2012 21:30:34 +0400 (MSK)
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

Hello,
I'm trying to get things working correctly for ASUS N75SF laptop and it
looks like I'm somewhat stuck.
The laptop has an ALC663 codec, 2 front speakers and an external
subwoofer. 
The 'auto' settings on 3.1.6 kernel provided me no meens of enabling the
subwoofer, the automute switch didn't work either. 
I threw on a patch with a quirk, that fixed most of the things except one:
Whatever I do, I get lfe to output front-right channel. 
I followed alc663_asus_21jd_clfe example, but still that only gives me a
volume control of that mixer. 
I'm not very familiar with alsa/hda codebase, so I might be missing some
trivia. 
Does the code have to register a pcm for each dac? If so, the problem is
in alc_build_pcms, since it looks like it only uses 
dac_nids[0]. Setting spec->multiout.max_channels in init code does not
help. 

my current n75sf_setup code is as follows: 


--- cut --- 
	struct alc_spec *spec = codec->spec;
	spec->autocfg.hp_pins[0] = 0x21;
	spec->autocfg.speaker_pins[0] = 0x14;
	spec->autocfg.speaker_pins[1] = 0x16;
	spec->automute = 1;
	spec->automute_mode = ALC_AUTOMUTE_PIN;
	spec->ext_mic_pin = 0x18;
	spec->int_mic_pin = 0x19;
	spec->auto_mic = 1;

--- cut ---

>From the codec's point of view, there are 3 dacs, 
nids 0x02 0x03
Either of these can serve stereo to front or headphone plug via mixers
nid 0x4 dac is the for lfe, only the second channel is wired. 
pin 0x16 (lfe) can only get stream from 0x4, which gets identical data as
dac 0x2

This is the point I do not know where to look for the bug. 


So far, my patch adds: 
* Proper automuting toggle switch (subwoofer now gets disabled as well,
when headphones are plugged). 
* Volume control for LFE channel (the stream is still identical to front
right) 
* Channel mode switcher (2ch, front only, 3ch - front + subwoofer enabled)
* (Mostly) working Headphone pin mode selection enum.
Things I still want to fix before sending in the patch:
* 5ch mode with headphone out configured as line-out for the rear
speakers, 
(Needs some things filled out and some testing as well)
* Toggle 2ch/3ch mode on subwoofer insertion (Still needs some
investigation and testing)
* Auto-mic and external mic need testing. 


Regards,
Andrew
 
