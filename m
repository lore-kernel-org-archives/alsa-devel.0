From: Matthew Yee-King <yeeking@no-future.com>
Subject: Re: vxpocket / alsa 0.91/ recording freezes the system
Date: Mon, 17 Mar 2003 22:23:07 +0000
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20030317222307.GB2453@bennyhill>
References: <08F1D234AF91E540BC1F43889E2A6AA70AEC2C@digiexch.digigram.com> <s5hk7eyuzpd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-user-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hk7eyuzpd.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Marc Titinger <titinger@digigram.com>, Matthew Yee-King <yeeking@no-future.com>, alsa-user@lists.sourceforge.net, "Alsa-Dev (E-mail)" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



> 
> i found it, too, and did a quick fix in the train returning from the
> LAD meeting last evening :)  please try the cvs version.


ok i've now got the cvs driver running. 

more observations:

- recording doesn't crash the system now!

- recordings are disorted when they come from the analog or digital 
input. (consumer spdif source)

e.g.:

http://www.yeeking.net/audio/vxpocket2_analog_in.wav
http://www.yeeking.net/audio/vxpocket2_spdif_in.wav

- recording with arecord through the spdif in from a pro spdif source 
(on my akai mpc 2000) fails - i just get a 44 byte file.

- the spdif out works fine - plugged it into my akai mpc 2000 - no 
problems. 

cheers

matthew


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
