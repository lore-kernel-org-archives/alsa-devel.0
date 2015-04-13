From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Mon, 13 Apr 2015 22:25:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.1504132224001.12482@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1504111011090.1174@localhost.localdomain>
 <s5hvbh13mxe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 119D92606D3
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 22:25:29 +0200 (CEST)
Received: by widdi4 with SMTP id di4so87865134wid.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 13:25:28 -0700 (PDT)
In-Reply-To: <s5hvbh13mxe.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Unfortunately I don't have the required competence to understand at the moment 
where those flags are in the relevant structs. And, unfortunately also, the 
"time"/environment. I'll let you know in case, I would like to help here.


Enrico Mioso
My Tox ID is:
1CE0149BA3E39A140B5AE1B2FEA1C0A1F92418345B829DA03F62583412E7474293C6F48A97E9

I like / reocmmend usage of open messaging standards: here are my XMPP IDs.
JIDs list:
- mrkiko@jit.si
- mrkiko@jabber.linux.it
- mrkiko@chrome.pl
- mrkiko@chatme.xyz
- mrkiko@alpha-labs.net

(XMPP allows server to server communications, so you might write to me using
any of these JIDs regardless the server you're connected to if
administratively allowed by your server or the destination one; I wanted to
see if some servers offered "innovative" / different services / for "fun",
still I am not experienced enough to discover them confortably. One JID would
have been enough.)

On Sun, 12 Apr 2015, Takashi Iwai wrote:

==Date: Sun, 12 Apr 2015 08:01:17
==From: Takashi Iwai <tiwai@suse.de>
==To: Enrico Mioso <mrkiko.rs@gmail.com>
==Cc: perex@perex.cz, hui.wang@canonical.com, david.henningsson@canonical.com,
==    kailang@realtek.com, alsa-devel@alsa-project.org
==Subject: Re: Intel HDA audio on EEE PC 1101HGo
==
==At Sat, 11 Apr 2015 10:13:51 +0200 (CEST),
==Enrico Mioso wrote:
==> 
==> When I plug in the jack and the audio is going, sometimes the audio will go to 
==> the headphones and to the PC speakers.
==
==It means that the unsol event hasn't been processed correctly.  We
==need to debug via trace points which verb triggers this, for example.
==(See Documentation/sound/alsa/HD-Audio.txt.)
==
==Usually when a communication stall happens it reports switching to
==polling mode.  This is already a suspect.  The stall at powering down
==to D3 is known on some codecs / controllers, so this itself isn't too
==serious.  But if this happens at anything else, it needs more care.
==
==> But stopping the audio and waiting for 
==> the controller to enter power save mode, and starting it again, solves the 
==> problem. But in my situation I had to ask the driver to reset the controller 
==> any time it exits power save:
==> options snd_hda_intel power_save_controller=1 power_save=5
==> so - I think the driver is not able to communicate properly with the device due 
==> to problems elsewhere, not of it's own. I would like so much to see what 
==> windows does in these cases. :)
==
==Yes, it's very likely some communication error that makes the codec
==hang.  It's interesting that the controller power save fixes it.  This
==implies that the problem is rather in the controller side.
==What if you set the following flags?
==	codec->bus->sync_write = 1;
==	codec->bus->allow_bus_reset = 1;
==
==
==Takashi
==
==> thank you guys for your work again - this intended to be an hilarious mail.
==> Have a good weekend.
==> Enrico
==> 
==> I have CONFIG_SND_HDA_INPUT_JACK=y (I know it's uncorrelated).
==> On Thu, 9 Apr 2015, Takashi Iwai wrote:
==> 
==> ==Date: Thu, 9 Apr 2015 17:59:15
==> ==From: Takashi Iwai <tiwai@suse.de>
==> ==To: Enrico Mioso <mrkiko.rs@gmail.com>
==> ==Cc: perex@perex.cz, hui.wang@canonical.com, david.henningsson@canonical.com,
==> ==    kailang@realtek.com, alsa-devel@alsa-project.org
==> ==Subject: Re: Intel HDA audio on EEE PC 1101HGo
==> ==
==> ==At Wed, 8 Apr 2015 21:40:53 +0200 (CEST),
==> ==Enrico Mioso wrote:
==> ==> 
==> ==> Hello guys.
==> ==> I am writing to you all to talk you about a strange behaviour of the Intel HDA 
==> ==> Audio device on an EEE PC 1101H.
==> ==> The audio device at some point simply doesn't react to commands, giving in 
==> ==> dmesgo utput like this:
==> ==> 
==> ==> [22321.638079] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching 
==> ==> to polling mode: last cmd=0x00170503
==> ==> [22322.641410] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching 
==> ==> to single_cmd mode: last cmd=0x00170503
==> ==
==> ==This looks already bad.  It means that power down of the codec
==> ==failed.
==> ==
==> ==But, the recent version should ignore this error.  There was a logic
==> ==failure to check this, but this was corrected recently.
==> ==
==> ==Could you check the latest 4.0-rc whether it works better?
==> ==If not, take alsa-info.sh output snapshots at good and bad working
==> ==moments.  Run the script with --no-upload option, and attach the
==> ==outputs (better compressed).
==> ==
==> ==
==> ==Takashi
==> ==
==> 
==
