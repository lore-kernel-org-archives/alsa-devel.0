From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Alsa-devel digest, Vol 1 #1207 - 14 msgs
Date: Wed, 4 Jun 2003 23:03:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306042302500.2783-100000@pnote.perex-int.cz>
References: <3EDE4C19.4050600@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EDE4C19.4050600@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Mark Knecht <markknecht@attbi.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Jun 2003, Patrick Shirkey wrote:

> Mark Knecht wrote:
> > 
> > 
> > Probably true, but I was told that using aplay would be automatic also,
> > and it wasn't. I've had to associate a pcm.!default entity to get it to
> > work, so something is not quite right. I continue to wonder if something
> > similar is effecting the OSS part of this machine.
> > 
> 
> Have you also symlinked /dev/dsp to /dev/adsp0 as that will allow oss 
> apps to use the hw:0,1 channel?

It not required. See to alsa-kernel/Documentation/OSS-Emulation.txt, look 
for 'dsp_map' and 'adsp_map'.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
