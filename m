From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Re: Alsa-devel digest, Vol 1 #1207 - 14 msgs
Date: Wed, 4 Jun 2003 15:00:14 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAEFFCGAB.mknecht@controlnet.com>
References: <Pine.LNX.4.44.0306042302500.2783-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306042302500.2783-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Mark Knecht <markknecht@attbi.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > >
> >
> > Have you also symlinked /dev/dsp to /dev/adsp0 as that will allow oss
> > apps to use the hw:0,1 channel?
>
> It not required. See to alsa-kernel/Documentation/OSS-Emulation.txt, look
> for 'dsp_map' and 'adsp_map'.
>
> 						Jaroslav
>
Patrick and Jaroslav,
   Interesting ideas. I'll goo look at these docs this evening.

   I think this may specifically be a Via82xx driver problem. If I change
only one line in modules.conf (snd-via82xx to snd-hdsp) the problem does
away, so I don't think it's anything specific about my setup, although it
could have something to do with my specific motherboard I guess.

   Anyway, thanks for the ideas.

Mark






-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
