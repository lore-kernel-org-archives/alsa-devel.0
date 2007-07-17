From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Re:
	=?iso-8859-1?q?snd-hda-intel=2C_=09AD_1988b=3A_SPDIF?=
	=?iso-8859-1?q?_output_not_working_correctly=2C_=09volume_low_for_?=
	=?iso-8859-1?q?analog_output?=
Date: Tue, 17 Jul 2007 18:22:56 +0200
Message-ID: <200707171822.58228.ml_alsa@mortal-soul.de>
References: <200707170832.01976.ml_alsa@mortal-soul.de>
	<s5hwswzwct6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 76C401038C1
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jul 2007 18:22:57 +0200 (CEST)
In-Reply-To: <s5hwswzwct6.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 July 2007 12:21:25 Takashi Iwai wrote:

> Which applications are you using?

Tested with amarok, kaffeine (and thus xine), mplayer, alsaplayer...

> For further analysis, first get /proc/asound/card0/codec#* files for
> both working and non-working states.  This includes most of codec
> register information, so we can compare the details.  In addition, run
> "alsactl -f somefile store" in both cases, too.  This file contains
> the mixer status.

Okay... it's hard to force it, so next time something like that happens, I 
will get the informations you asked for. (I already attached several infos to 
my last mail) Is there something else I can do or provide you with in the 
meantime...?

> Also, check the kernel messages when it hangs.  If it's related to the
> controller communication error, it must show some timeout messages.

There are no kernel msgs... already checked that.

> No, it's almost same (if we rely on the datasheet).

Different revision maybe...?

> Did you try any model module option?  It might be a BIOS problem that
> doesn't set up the codec informatoin correctly.  With model option, we
> can override and use the preset configuration.

Yeah... tried several things so far.


1] model option

With the auto setting, I can raise the volume a lot louder. Unfortunately 
every sound I play back through spdif (non-ac3) seems overamplified even if I 
lower the iec958 volume below -45db. I cannot get that right. Also in order 
to correctly set the front volume, I have to adjust the headphone volume as 
well. If I don't, the front sounds dull somehow. Also tried other variants 
but usually one of the speakers isn't working or stuff like that.

Currently I am using 6stack-dig with the problems outlined in my earlier mail.

Unfortunately neither with the auto setting, nor with 6stack-dig, I am able to 
switch the output mode (6 channel, 2 channel, ...). It's always 6 channels 
and whatever I play back is routed to every speaker. :-(

2] position_fix

I don't seem to have any luck with that one. Doesn't solve any problems... 
with setting at 3, things are even worse with more distortions.


So... I could live with the occasional spdif hang but is there something I can 
do about those distortions I hear with spdif and non-ac3 stuff played back? I 
can even hear it when nothing is being played back. Interestingly, the 
distortions are gone when ever I have played back something ac3 (passthrough) 
until I play back something non-ac3.

Thanks again,
matthew.
