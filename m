From: Richard Chan <rspchan@starhub.net.sg>
Subject: ALC655 in CVS: Are Center/LFE switched with Surround?
Date: Wed, 19 Nov 2003 23:04:57 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBB8699.10602@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I've finally got 5.1 out of my via82xx/ALC655 system using the 
Line-In/Mic jacks!
Thanks Takashi.

However I seem to have got Center/LFE switched with Surround.
I.e. if I play xine & mplayer (L, R, RearL, RearR, Center, LFE)
through surround51 I get Center/LFE switched with Rear speakers.

I must use the following to work in .asoundrc
pcm_slave.sltest {
    pcm "hw:0,1"
    channels 6
}

pcm.via51 {
    type plug
    ttable.0.0  1
    ttable.1.1  1
    ttable.2.4  1
    ttable.3.5  1
    ttable.4.2  1
    ttable.5.3  1
    slave sltest
}

Has anyone else observed this problem?



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
