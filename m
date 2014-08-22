From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Grey noise with HDA Intel PCH
Date: Fri, 22 Aug 2014 18:18:28 +0200
Message-ID: <20140822181828.7136684d@saldaea>
References: <20140814114003.7b0019f3@saldaea> <53EC8D5B.5020709@ladisch.de>
 <20140814124616.65991d7e@saldaea> <s5hoavnnu38.wl-tiwai@suse.de>
 <20140814160737.0e8fc283@saldaea> <s5h7g2bnowg.wl-tiwai@suse.de>
 <20140814163914.08e9a851@saldaea> <s5h38cznn59.wl-tiwai@suse.de>
 <20140814170459.31428e0b@saldaea> <s5hwqabm7h7.wl-tiwai@suse.de>
 <20140814172658.75bd122f@saldaea> <s5hppg3xeag.wl-tiwai@suse.de>
 <20140814182919.03b49822@saldaea> <s5hk36awarl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A1E14260864
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 18:18:33 +0200 (CEST)
In-Reply-To: <s5hk36awarl.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Fri, 15 Aug 2014 08:02:38 +0200
schrieb Takashi Iwai <tiwai@suse.de>:

> At Thu, 14 Aug 2014 18:29:19 +0200,
> Julian Wollrath wrote:
> > 
> > > > > > > Thanks.  The setup looks OK, the path is:
> > > > > > >   DAC (0x02) -> mixer (0x0c) -> mixer (0x14)
> > > > > > > and the mixer mutes the loopback path (index 1).
> > > > > > > 
> > > > > > > Is it the state where you still hear the static noise?
> > > > > > Yes, the alsa-info.sh script was executed, while hearing the
> > > > > > static noise.
> > > > > 
> > > > > OK.  And if you mute "Speaker" or "Headphone", the noise is
> > > > > gone, too, right?
> > > > No, if I mute "Speaker" (the internal laptop speaker) it is not
> > > > gone. It is only gone, if I mute "Master" or have a headphone
> > > > plugged in and mute "Headphone" or "Master".
> > > 
> > > Interesting.  The "Speaker" mute changes "Speaker Playback
> > > Switch", and as you can see in alsa-info.sh output, this toggles
> > > the mute of the speaker pin NID 0x14, i.e. the endpoint.  If
> > > "Master" influences, it means to mute *both* Headphone and
> > > Speaker mutes would work. Could you check this?
> > Muting both Headphone and Speaker does not work for the static
> > noise on the speaker.
> 
> Then check what's the difference in codec proc content between the two
> cases: Master=mute and Headphone+Speaker=mute.
> 
> > > > More fascinating, it is not present, if the speaker is not muted
> > > > and I disable powersaving via "echo '0' >
> > > > '/sys/module/snd_hda_intel/parameters/power_save'" but even
> > > > then, it is still present on the headphone.
> > > 
> > > Hm.  Is the noise audible when you playback a PCM stream, too?
> > > For example, you can play a silent stream.
> > Yes, then it is audible.
> > 
> > > > > > > Also, what if you use the module option for snd-hda-intel
> > > > > > > model=nofixup or model=generic?
> > > > > > That did not change anything either. Passing the "mixer_nid
> > > > > > = 0" hint also did not get rid of the static noise, when
> > > > > > loading snd-hda-intel with model=nofixup resp.
> > > > > > model=generic.
> > > > > 
> > > > > Did you reboot with setting the option in /etc/modprobe.d/*?
> > > > > Reloading the module might not work for such a problem.
> > > > No, I just unloaded every sound-related module and than loaded
> > > > the module via "modprobe snd-hda-intel model=..." again.
> > > 
> > > Then always test with reboot.  The problem is about the
> > > vendor-specific setups, and it's often sticky unless the cold
> > > boot. At best, do the cold boot.  The warm boot doesn't cure
> > > always.
> > Ok, I tested with a reboot but that did not help.
> > 
> > > > > In either way, there should be some difference in alsa-info.sh
> > > > > output, e.g. more (or less) mixer items with the model option.
> > > > The difference is their, all the "Dock ..." entries were
> > > > missing, when loading with the model="..." option.
> > > 
> > > Yes, and you should also see the difference in the kernel
> > > messages.
> > > 
> > > Another thing to check is to swap the DAC assignment.  There was a
> > > similar problem on some Sony laptops, and we had to swap the DAC
> > > assignment since the hardware seems to have some implicit
> > > assumption of the DAC.  A test patch is below.
> > Thanks, but sadly the patch did not help.
> 
> I have no much other clue, so far.  The rest you can test is to toggle
> EAPD, toggle GPIO pin, and change the different pin setups, e.g. put
> VREF or HP amp bit on any (even unused) pins.
Toggling the EAPD got rid of the noise but I also did not get any sound
output anymore. Playing with the other pins got me nowhere. Seems like
I have to live with the noise.

Nevertheless, thank you for your help.


Cheers,
Julian
> 
> 
> Takashi
