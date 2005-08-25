From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Fri, 26 Aug 2005 01:12:45 +0800
Message-ID: <430DFC0D.1010502@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <430B3EA0.1000903@netvigator.com> <s5hr7ck4lmt.wl%tiwai@suse.de> <200508232340.46629.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508232340.46629.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>
Cc: Manuel Jander <manuel.jander@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alien wrote:

> 
> anyway, i really need to do the latest tests, i have way too many adb failures 
> lately.

What do you means when you say "adb failures" ? ( any message in system
log )

> 
> it mostly happens, when watching a movie and gaim starts a little sound.
> 
> i've determined that it's not likely to be the max available sounds, but more 
> likely to be the weird scheduling of sounds at the same time
> 
> i urge you people to chat more using some program that starts little sounds 
> so, you have lots of short start and stops at the same time, maybe use gaim 
> for ICQ and IRCing, that always gives me plenty of sounds...
> 
> PS: i forgot the latest patch i had to try out.

Don't forget the latest patch "Fixed missing spin_unlock" on CVS .

> 
> I'll do one patch to try out, and hope it doesn't require me to reboot this 
> machine...
> 
> i'm using alsa CVS from some weeks ago, i think

Although I can play multiple mono sound streams on device 2 on my au8830.

I don't know why the connection routine of device 2 is disabled only on
au8810 driver.

If you have any application using device 2 to playback (e.g. 3D demo in 
vortexcontrol), wierd things may happen on au8810 since some of the 
route and mixer of device 2 playback stream has not been assigned.








-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
