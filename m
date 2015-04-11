From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Sat, 11 Apr 2015 10:13:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.1504111011090.1174@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 435862612BD
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 10:13:55 +0200 (CEST)
Received: by wgso17 with SMTP id o17so37047297wgs.1
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 01:13:54 -0700 (PDT)
In-Reply-To: <s5hegntl2cs.wl-tiwai@suse.de>
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

When I plug in the jack and the audio is going, sometimes the audio will go to 
the headphones and to the PC speakers. But stopping the audio and waiting for 
the controller to enter power save mode, and starting it again, solves the 
problem. But in my situation I had to ask the driver to reset the controller 
any time it exits power save:
options snd_hda_intel power_save_controller=1 power_save=5
so - I think the driver is not able to communicate properly with the device due 
to problems elsewhere, not of it's own. I would like so much to see what 
windows does in these cases. :)
thank you guys for your work again - this intended to be an hilarious mail.
Have a good weekend.
Enrico

I have CONFIG_SND_HDA_INPUT_JACK=y (I know it's uncorrelated).
On Thu, 9 Apr 2015, Takashi Iwai wrote:

==Date: Thu, 9 Apr 2015 17:59:15
==From: Takashi Iwai <tiwai@suse.de>
==To: Enrico Mioso <mrkiko.rs@gmail.com>
==Cc: perex@perex.cz, hui.wang@canonical.com, david.henningsson@canonical.com,
==    kailang@realtek.com, alsa-devel@alsa-project.org
==Subject: Re: Intel HDA audio on EEE PC 1101HGo
==
==At Wed, 8 Apr 2015 21:40:53 +0200 (CEST),
==Enrico Mioso wrote:
==> 
==> Hello guys.
==> I am writing to you all to talk you about a strange behaviour of the Intel HDA 
==> Audio device on an EEE PC 1101H.
==> The audio device at some point simply doesn't react to commands, giving in 
==> dmesgo utput like this:
==> 
==> [22321.638079] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching 
==> to polling mode: last cmd=0x00170503
==> [22322.641410] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching 
==> to single_cmd mode: last cmd=0x00170503
==
==This looks already bad.  It means that power down of the codec
==failed.
==
==But, the recent version should ignore this error.  There was a logic
==failure to check this, but this was corrected recently.
==
==Could you check the latest 4.0-rc whether it works better?
==If not, take alsa-info.sh output snapshots at good and bad working
==moments.  Run the script with --no-upload option, and attach the
==outputs (better compressed).
==
==
==Takashi
==
