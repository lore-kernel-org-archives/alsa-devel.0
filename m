From: Steffen Sauder <steffensauder@gmx.de>
Subject: 1.0.0pre1 / ice1712 / mplayer-oss-delay
Date: Thu, 20 Nov 2003 11:01:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBC90F4.8080708@gmx.de>
References: <s5hn0as1hvn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0as1hvn.wl@alsa2.suse.de>
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

Takashi Iwai wrote:

>- PCM OSS emulation was fixed, e.g. mplayer delay problem should be
>  fixed now.  Hopefully this doesn't introduce another bug...
>
Strange, the new version doesn't seem to behave any different than the 
last cvs version I tested (Nov-02) (is there maybe any reason why make 
install wouldn't properly update everything?). Skipping in mplayer or 
xmms sill takes half a second, mpg123 needs >30 seconds for starting 
playback as well as java-apps do. I still have a DMX6fire and am running 
gentoo with kernel 2.4.20-gentoo-r5. If you need debugging infos please 
ask, I'm still not sure if the strace-info I sent you once was useful or 
not.

>- some bugs in OSS-emulation library are fixed.  please test!
>
Are any of those bugfixes related to the problems mentioned above? If 
not I don't really know where to start testing...

>
>- dmix problems with xmms ALSA plugin is solved.
>
I think I can confirm that, I noticed some problems with sample rate 
conversion before that seem to be gone.

Again thanks a lot for your effort on these issues,
Steffen



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
