From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: [linux-audio-dev] dynamic linking
Date: Tue, 23 Apr 2002 22:18:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020423221803.B17903@ecs.soton.ac.uk>
References: <001501c1eaf8$d359ef00$0400a8c0@martijn> <200204231833.g3NIXre19975@roar.music.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecs.soton.ac.uk (inanna.ecs.soton.ac.uk [152.78.65.48])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA22236
	for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2002 23:18:10 +0200
Content-Disposition: inline
In-Reply-To: <200204231833.g3NIXre19975@roar.music.columbia.edu>; from pbd@op.net on Tue, Apr 23, 2002 at 02:26:33 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 23, 2002 at 02:26:33 -0400, Paul Davis wrote:
> >I'm working on a library for accessing MIDI hardware, which uses plugins
> >to communicate with the hardware. Now I'm not sure how to compile
> >these shared libraries. Should I use -Bsymbolic? This makes the linker
> >give a warning when the library is not linked against all the shared
> >libraries
> 
> although i hate it in so many ways, i would strongly suggest that you
> use libtool. there are complexities associated with building shared
> libs that its better to leave to other tools.

I wouldn't recommend libtool for .so plugins, it makes a real mess of it.

I link with "ld -shared -Bsymbolic -lc -lm -o $@", but YMMV.

- Steve

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
