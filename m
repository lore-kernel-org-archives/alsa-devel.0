From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: 24bit format support on usb audio
Date: Sun, 30 Jun 2002 06:28:37 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1E2685.1080704@boosthardware.com>
References: <s5hbsa8h7fa.wl@alsa2.suse.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, pbd@op.net
List-Id: alsa-devel@alsa-project.org

- This is with code that Takashi sent me privately -

I did some testing earlier with playback. Using alsaplayer with alsa 
drivers I get a nice smooth stream with no dropouts.

However using the JACK plugin I get constant cracks/pops which act like 
a delay.  Any idea why that could be?

With the new code I can now hear and capture sound through the input 
channels using jack, ardour and alsaplayer. Nice :) I cannot hear the 
sound if I use the native alsa drivers. This appears to be the same 
functionality that I observed in windows using cubase and ASIO. Except I 
couldn't access the sound card in any way using the standard dohs 
drivers but using the cubase+ASIO I could record and play back. At least 
with ALSA I can get playback happening.

I now get active meters in ardour so I can adjust the levels using 
ardour mixer. I can record the signal and have made an ogg file so you 
can hear what is happening here.

http://www.boosthardware.com/LAU/

(shift+click on the quattro2.ogg file)

This works for me using xmms but alsaplayer has problems with the speed 
of playback here so if you use alsaplayer to listen to it and it seems 
out of sync that is not the problem. However Andy has tested my oggs on 
his system and has found no problems with them. YMMV.

Thanks Takashi and Paul. The combination of USB sound card and multiple 
apps interacting with each other is a huge achievement to which you both 
have contributed greatly through your tireless work on ALSA and/or JACK.

You have made my night.




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
