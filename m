From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio problems
Date: Sat, 22 Nov 2003 01:50:48 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBE4268.1090608@boosthardware.com>
References: <3FBBC461.1020006@opersys.com>	<3FBC560B.7040104@opersys.com>	<s5hoev7ywfw.wl@alsa2.suse.de>	<3FBCD0D0.3020404@boosthardware.com> <s5hoev54uie.wl@alsa2.suse.de>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: karim@opersys.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> 
> no, it has nothing to do with the latency but oopsen / lock-up.
> the problem exists only at stopping the streams.  if the everything is
> ok, it's not a big issue.  but, when the device runs with small
> latency, which may result in xrun often, has the higher probability to
> hit this bug, because ALSA tries to stop the stream if xrun happens.
> 

Thanks. There should be a disclaimer somewhere for this problem.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
