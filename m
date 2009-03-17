From: Santo Chow <santo_chow@yahoo.com>
Subject: Re: Need help on getting raw audio stream from a dummy
	sound card
Date: Mon, 16 Mar 2009 23:22:25 -0700 (PDT)
Message-ID: <735382.67435.qm@web110804.mail.gq1.yahoo.com>
References: <528253.23902.qm@web110802.mail.gq1.yahoo.com>
	<s5hhc21ienk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web110804.mail.gq1.yahoo.com (web110804.mail.gq1.yahoo.com
	[67.195.13.227]) by alsa0.perex.cz (Postfix) with SMTP id 3397E10387B
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 07:22:27 +0100 (CET)
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

Hi Takashi,

I have followed your suggestion and now i'm faced with another problem. So, right now, i have a Loopback soundcard as my default. My .asoundrc looks like this:

pcm.!default{
   type hw
   card 1
}

Card
0 is my actual soundcard (that can actually produce sound). Card 1,
when i checked on the /proc/asound/cards actually pointing to Loopback
card. So right now, the way i test the card 1, is to call arecord from
card 1, and play it to card 0. Right now, i'm still developing this in
my ubuntu PC.

so i ran this
arecord -f cd -D hw:1,1 | aplay -f cd -D hw:0

in
one terminal, and in the other terminal i can play mplayer, watching
youtube, etc.. and the sound would come out nicely. (Thanks to all of
your efforts, nevertheless)

But I notice that, when i play
mplayer, then i open a web-browser, and surf youtube, the sound from
youtube is gone. But if i close the browser, close the mplayer, then
reopen the browser, go to youtube and play a video, i can hear the
sound nicely. but then, if during the time i start mplayer, it will
complain about 'no sound'. Turns out, I have to use dmix. So, i modify
my .asoundrc like this:

pcm.!default {
   type plug
   slave.pcm "dmixer"
}

pcm.dmixer  {
   type dmix
   ipc_key 1025
   slave {
      pcm "hw:0,0"
      rate 44100
   }
   bindings {

  0 0
      1 1
   }
}
i put 'pcm "hw:0,0" ' over there, because i want to make sure that this setting works with my actual sound card first. If it works with my card 0, it should work with my card 1. with
the above .asoundrc file, i can play multiple sound from different
application at the same time. I even tried to remove the "bindings"
tag, and it still able to play multiple sound very well. so i guess,
this should work on my card 1.

then i change the .asoundrc become like this again:


pcm.!default {
   type plug
   slave.pcm "dmixer"
}

pcm.dmixer  {
   type dmix
   ipc_key 1025
   slave {
      pcm "hw:1,1"
      period_time 0
      period_size 881
      buffer_size 3524
      rate 44100

 }
}the value for perio_time,
period_size, and buffer_size have been adjusted by me to suits my
hardware requirement. This is the setting that works on my machine.
It's just that, in the end, I'm still ended up with one sound at a
time. I can't run mplayer + youtube at the same time. I can only run
one of them. And furthermore, if i just paused the mplayer, the audio device is still locks. It will be good enough if someone can hint me a way to unlock the audio device.

So,
what i want to ask is.. can this Loopback card handle more than 1 sound
at a time? Have anyone tried this before? I have tried changing the
value of .asoundrc, switching the slave pcm to pcm "hw:1,0" (not
working) pcm "hw:1" (works, but only 1 sound too). Any idea guys?


Santo




________________________________
From: Takashi Iwai <tiwai@suse.de>
To: Santo Chow <santo_chow@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Tuesday, March 10, 2009 11:25:03 PM
Subject: Re: [alsa-devel] Need help on getting raw audio stream from a dummy sound card

At Thu, 5 Mar 2009 08:34:03 -0800 (PST),
Santo Chow wrote:
> 
> Hi everyone :)
> 
> I'm currently assigned to a task that requires me to capture raw audio stream from a dummy sound card. Is this even possible?

You can use aloop driver in alsa-driver tree for such a purpose.
Then you can capture streams freely from the currently running playbacks.


Takashi
