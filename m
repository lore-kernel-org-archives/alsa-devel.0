From: "Lubomir Schmidt" <017623780966@o2online.de>
Subject: Re: Prolem with ALC260 soundcard
Date: Thu, 5 Oct 2006 15:54:46 +0200
Message-ID: <200610051354.k95DskFH016320@mail04.o2online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail04.o2online.de (mail04.o2online.de [82.113.101.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8933224B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 15:54:48 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: jwoithe@turbo.physics.adelaide.edu.au, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is the lspci -vv (shows more then -v ;-)  )
http://pastebin.ca/191868

and the cat /proc/asound/card0/codec#0
http://pastebin.ca/191871

I can rememebr that i have read in the alsa bugtrack that i am not the only one with an ALC260 chip who helped that alc883 patch. I olso remember that i have sound since the 1.0.13rc2 or rc3 release (i have installed extra the suse 10.2 alpha 4 to try the driver). In release 1.0.13rc1 came that ALC883 patch.

I do not know how i could add compile-options when i compile something. I use gentoo and work with portage. Could you put the different things into model=acer in the new RC releases? The Acer have an headphone and an mic jack. There is no otehr jack.

I have tested again the mic jack. The sound that comes out there is louder and have no bass. I think that is the sound that had to come out of the speaker. I remember the sound that comes out of the speaker when i had windows installed (i have no windows on it now). It had olso no bass.

The mic that is been build into the notebook is working. I can hear that, when i turn in alsamixer the mic to maximum and unmute it. When i go with my finger over the mic, i can hear that through the headphone and the mic jack. That mic only work when i set "mic jack" = "Mic 50pc" or "Mic 80pc". 

Hey, in the time i write the text here i found out why i had sound out of the mic jack. The "Line Jac" was on "Line out". When i turn that into "Line in,Mic 50pc or Mic 80pc" i can not hear anything more coming out of the mic jack. When it is set to line out or headphone i can hear the music that i have started with amaroK(internet radio stream).

Thank you for the support

------old mail--------
> Hello, i have an acer c204 Notebook with an ALC260 chip inside. Since one
> month i have sound on it, because of the ALC883 patch for acer notebooks.

Hmm, that's marginally odd.  I wouldn't expect the ALC883 patch to have any
effect on your laptop if you truly have an ALC260.  The ALC260 hasn't had
any major changes for a while so it's a little strange that things have
changed recently.

Could you send me the output of 
  lspci -v
as well as the result of the command
  cat /proc/asound/card0/codec#0

> When i set "options snd-hda-intel model=acer" in the modprobe.conf, then i
> have sound over my headphones, but no sound is comming out of the speaker.

If this Acer is anything like others and it truly does use the ALC260 (eg:
Travelmates) it could be that we need to activate more than just GPIO0 on
your particular laptop.  Currently the ALC260 Acer model turns GPIO0 on
which on the Travelmates means both the headphone jack and the internal
speaker can work.  Perhaps the c204 uses GPIO0 for the headphone jack (since
you report that working) and GPIO1 (for instance) for the internal speaker.

However before proceeding we have to confirm exactly which chip is in your
notebook, as described previously.

> I olso saw, that when i put my headphones inside the mic, then i olso have
> sound. That sound have not as good quality as that from the headphones
> jack and its louder.

Now *that's* odd.  This seems to suggest that the c204 may be wired
totally differently to the Travelmate from the point of view of which
pins on the ALC260 chip go where.

Could you give me a complete list of the audio jacks provided on your
laptop.  I guess there's at least a "headphone" jack and one labelled "mic".
If there are any others, what are they?

> Can someone tell me what i could do to get sound out of my speaker?

Are you comfortable/familiar with configuring and compiling ALSA?  We
are possibly going to have to get you to run some tests with the "test"
ALC260 model but that will require you recompile ALSA.

Regards
  jonathan





-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
