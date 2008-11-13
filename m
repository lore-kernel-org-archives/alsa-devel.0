From: Andrei Tanas <andrei@tanas.ca>
Subject: Re:
 =?utf-8?q?Asus_P5QL-EM_motherboard_=28ALC1200_codec?=
 =?utf-8?q?=29_-=09no=09sound_through_S/PDIF?=
Date: Thu, 13 Nov 2008 09:48:31 -0500
Message-ID: <83a4f998c39b305b96a147ea4e52c1c0@localhost>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de> <s5htzacqbg8.wl%tiwai@suse.de>
	<5cc3284c7cc701236ffb50fffa632d8e@localhost>
	<s5hk5b7hf9y.wl%tiwai@suse.de>
	<c11e940b1b3df5cb95e63f38b1b54416@localhost>
	<s5hhc6bhep3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 418F22457A
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 15:48:33 +0100 (CET)
In-Reply-To: <s5hhc6bhep3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Nov 2008 15:40:24 +0100, Takashi Iwai <tiwai@suse.de> wrote:
>> Simple mixer control 'IEC958',0
>>   Capabilities: pswitch pswitch-joined cswitch cswitch-joined
>>   Playback channels: Mono
>>   Capture channels: Mono
>>   Mono: Playback [on] Capture [off]
>> Simple mixer control 'IEC958 Default PCM',0
>>   Capabilities: pswitch pswitch-joined
>>   Playback channels: Mono
>>   Mono: Playback [on]
>> 
>> Is that normal?
> 
> What do you mean "PCM Out" at all?

http://alsa.opensrc.org/DigitalOut says: 'set to "PCM Out"'

>From some other reports, I expected to see something like this:

Simple mixer control 'IEC958',0
 Capabilities: enum
 Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
 Item0: 'PCM Out'
Simple mixer control 'IEC958 Output',0
 Capabilities: pswitch pswitch-joined
 Playback channels: Mono
 Mono: Playback [on]
Simple mixer control 'IEC958',1
 Capabilities: enum
 Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
 Item0: 'PCM Out'
