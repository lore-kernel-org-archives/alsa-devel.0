From: Thomas Fjellstrom <tfjellstrom@telusplanet.net>
Subject: Re: final release - Tuesday
Date: Sun, 9 Mar 2003 10:43:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303091043.29357.tfjellstrom@telusplanet.net>
References: <Pine.LNX.4.44.0303100108560.5732-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from priv-edtnes27.telusplanet.net (outbound04.telus.net [199.185.220.223])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA23265
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 06:42:18 +0100
Received: from lazybones.dyndns.org ([66.222.183.148])
          by priv-edtnes27.telusplanet.net
          (InterMail vM.5.01.05.17 201-253-122-126-117-20021021) with ESMTP
          id <20030310054145.OQCH9999.priv-edtnes27.telusplanet.net@lazybones.dyndns.org>
          for <alsa-devel@alsa-project.org>; Sun, 9 Mar 2003 22:41:45 -0700
In-Reply-To: <Pine.LNX.4.44.0303100108560.5732-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On March 9, 2003 05:13 pm, Jaroslav Kysela wrote:
> Hi all,
>
> 	I have just released the 0.9.0rc8d version of the ALSA driver for
> tests. It should fix the trident problems as Paul noticed. If no major bug
> is reported until Tuesday, I will release the final packages.
>
> 					Have fun,
> 						Jaroslav
>

Hey,

I've brought this up a couple times, and It looked like Takashi was working on 
it. I added alsa 0.5 and 0.9x rawmidi support to a library called Allegro 
(alleg.sf.net) but since upgrading to alsa 9x (I also just installed the 
latest release from alsa-project.org) the midi test app that comes with 
allegro (and a midi player of mine...) will eventually (in a couple minutes) 
eat up 100% cpu time. The allegro midi system has no problems with its 
software synth, in OSS (or so I've heard), Windows, or any of the other 
platforms it supports.

I have:
kernel 2.4.19 (+ preepmt patch)
latest alsa stuff
GCC 3.2.2
Debian Cid

Thanks!

p.s. I have to say, Great work :)

-- 
Thomas Fjellstrom
tfjellstrom@telusplanet.net
http://strangesoft.net


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
