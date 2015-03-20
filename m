From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
	ALSA: digi00x:	apply double-oh-three algorism to multiplex
	PCM samples
Date: Fri, 20 Mar 2015 14:00:08 +0100
Message-ID: <550C19D8.1050803@ladisch.de>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>	<1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>	<5506E7EE.6060300@gareus.org>
 <55070409.8090107@sakamocchi.jp>	<55070F3B.7000509@gareus.org>
 <55075D65.20406@sakamocchi.jp>	<55082E06.6010008@gareus.org>
 <55083103.5030704@gmail.com>	<5508CFA5.7060903@sakamocchi.jp>
 <550AD65F.10803@gareus.org>	<550B51BC.80506@sakamocchi.jp>
 <550C0CFC.4060404@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B719B260851
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 14:00:10 +0100 (CET)
In-Reply-To: <550C0CFC.4060404@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Damien Zammit <damien.zammit@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Robin Gareus wrote:
> On 03/19/2015 11:46 PM, Takashi Sakamoto wrote:
>> For example, to control the clock selector of Digi 002/003 family, we
>> just execute this command with firewire-request.
>>
>> $ ./firewire-request /dev/fw1 write 0xffffe0000118 0x0000000[0|1|2|3]
>
> Yes, that's what I was asking about. Can one safely write raw control
> messages to /dev/fw* without interfering with ongoing streaming?

Yes.  If a device did not allow this, or if the mixer accesses would be
part of the audio stream, the driver would have no choice but to
implement this in the kernel.  But this is not the case for most devices.

> Instead interfacing via established protocols /dev/snd/control* or
> rather libasound's snd_mixer_t seems like a no-brainer to me.

It is possible to attach 'virtual' mixer controls to hardware sound
cards.  (This was originally designed for the software volume control.)

The only reason that FFADO did not use this was that there was no
suitable ALSA card instance to attach to.


Regards,
Clemens
