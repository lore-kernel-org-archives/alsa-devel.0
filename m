From: Tom Watson <sdc695@yahoo.com>
Subject: I thought it would simple....
Date: Tue, 22 Jul 2003 23:54:49 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030723065449.40812.qmail@web21508.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I am attempting to write a "simple" audio playback program.  Well, I
thought it would be, but...
Somehow (thru strace) the 'snd_pcm_writei' call goes and eventually
does a system 'poll' call, but it doesn't return indicating that a
write is OK to do.
I've used similar parameters in 'aplay' and I see that it works.

The basis of the program I'm writing is the one described in _A
Tutorial on Using the ALSA API_
(http://equalarea.com/paul/alsa-audio.html), section entitled "A
Minimal Playback Program".

One thing I've noted:  Some of the data printed out by "snd_pcm_dump"
is different between my program and 'aplay'.  I suspect that there is a
clue somewhere, but what is the "magic"??

If necessary, I can provide the 'strace' or the output from
'snd_pcm_dump', but in the interest of brevity...

Any "great clue" would be appreciated.

Thanks.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
