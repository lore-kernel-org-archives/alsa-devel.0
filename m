From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: right way to enumerate pcm devices
Date: Wed, 13 Feb 2019 15:38:04 +0100
Message-ID: <dd9a3463-b21b-6351-b8d6-a56930fba3d8@perex.cz>
References: <20190212123333.GB6441@freedom> <s5hr2cd3z9b.wl-tiwai@suse.de>
 <20190212203324.GA1399@freedom> <s5hpnrwciie.wl-tiwai@suse.de>
 <20190213141328.GA358@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BA6E9267483
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 15:38:07 +0100 (CET)
In-Reply-To: <20190213141328.GA358@freedom>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sylvain.bertrand@gmail.com, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 13. 02. 19 v 15:13 sylvain.bertrand@gmail.com napsal(a):
> On Wed, Feb 13, 2019 at 07:25:13AM +0100, Takashi Iwai wrote:
>> It's only the matter of alsa-lib card config.  Just due to heuristic
>> reason, the secondary device is assigned as iec958 as default.  There
>> are explicit whitelist setup in alsa-lib/src/conf/cards/USB-Audio.conf
>> for the card that behave differently.  You'd need to adjust
>> accordingly.
> 
> Tell me if I did understand you right:
> 
> I cannot trust the hint system to select proper pcm devices for, let's say the
> mic of my USB cam.

As Takashi noted, we can fix this for your device in the alsa-lib's
configuration file to not show the extra invalid surround devices, but
it does not mean that the other USB devices are not affected. We are
always a little bit behind the hardware. The library does not do any
probing for the available channels when the devices are enumerated.

> I would have to ignore "mostly" the configuration system (the major exception
> would be the default pcm device) and build myself the pcm devices from the info
> I can get from the hardware device (hardware mixing, input and/or output,
> number of channels/etc).
> 
> I would have to cherry pick configuration defined pcm devices for specific
> modes, like surroundX, only if the "basic user" explicitely requests such modes.
> 
> The advanced user should override the default pcm device if he/she wants to
> do/fix tricky sound thingies.
> 
> ----
> 
> To summarize:
> 	- show always the pcm default
> 	- build custom pcm devices based on hardware info, and show them
> 	- for "special" modes, likes surroundX, show the related configuration
> 	  defined pcm devices only if the "basic" user want to fool around with
> 	  them.

This is not optimal. It would be better to settle something in the one
place. I would start to fix the blacklists in
/usr/share/alsa/cards/USB-Audio.conf for your device (and post the
alsa-lib's patch here).

Perhaps the USB driver might forward also more hints/parameters about
the device characteristics to improve this hint system.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
