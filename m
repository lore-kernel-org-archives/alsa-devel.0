From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Hints on configuring EGPIO on cs46xx
Date: Thu, 26 Sep 2002 23:43:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D937F83.2080609@cucumelo.org>
References: <1033056560.18349.3.camel@pete>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Peter Good <psgood@petesinternet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>I've just tried the CVS, and am having a little trouble configuring a
>Hercules Game Theater XP. I've got the modules installed, cs46 comes up
>correctly, and I do get sound, but it's doing what was referred to in
>the other thread about this module. Sound is flat, no bass or anything.
>I'm not really sure on how to set the EGPIO, have had a play with it,
>but can't seem to resolve the problem.
>
>Anyone got any useful hints on how to actually set cs46xx up for a
>Gametheater, using optical out?
>  
>
I've got a Hercules Game Theater XP,what's known for moment is that: 
EGPIO0 selects the SPDIF input,
the EPGIO2 turn on the Amplifier, and that's implemented in the current 
driver.
With the Game Theater XP, the Amplifier is turned on all the time, with 
the exception if you unmute
the CD in the mixer, (this is for all cs46xx  cards). Dont known why 
it's done in this way, probably with
a good reason in mind, i've just complained about that piece of, not 
touched it (yet).
If the sound card  amplifier is turned off for some reason the sound 
gets somewhat lower, bad and distorcionated,
about the "flat bass", I have not experienced that. I daily use the 
HeadPhones, and I got my the SPDIF
output connected to the receiver. To activate the SPDIF it should only 
be to unmute the "IEC 958 Output" in
the mixer, no GPIO's are involved on the Game Theater card.

About the SPDIF output the analog parts of the soundcard should not 
matter at all, it's like whatever what you playback
will be sent directly "as it is sampled" to the SPDIF output, it's up to 
the Stereo reciever (or whatever you got ...) to do the DAC stuff.

/Benny
/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
