From: Pavel Roskin <proski@gnu.org>
Subject: Re: Support form terratec DMX-6fire
Date: Mon, 30 Sep 2002 15:18:33 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209301514440.6403-100000@marabou.research.att.com>
References: <3D988C9A.3030807@hccnet.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D988C9A.3030807@hccnet.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jogchum Reitsma <j.reitsma@hccnet.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> Is there any chance that in the ALSA-project a driver for the Terratec 
> DMX-6fire (ICE1712 chip) is developed? Would be very nice. I'm a 
> C-programmer myself, but without experience whatsoever in developing 
> drivers at all, let alone drivers with timing problems as is the case 
> with soundcard drivers. So if anyone of you...

Not having experience in developing the drivers is not excuse for not
looking in the existing code.  alsa-kernel/pci/ice1712/ews.c (from CVS)  
begins with the comment:

 *   ALSA driver for ICEnsemble ICE1712 (Envy24) 
 * 
 *   Lowlevel functions for Terratec EWS88MT/D, EWX24/96, DMX 6Fire 

I guess you should just try the snd-ice1712 driver and report problems
(very detailed!) when you come to the point when your experience is
insufficient to solve them.  That's what I do, and it worked for me just
fine.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
