From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: DMIX and capture stream
Date: Mon, 5 Jan 2004 17:21:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401051710250.1862@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0401021421520.4466@tomservo.workpc.tds.net>
 <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
 <20040104145223.25bddac3.mista.tapas@gmx.net> <Pine.LNX.4.58.0401041746270.12698@ultros>
 <3FF8FD7C.60508@boosthardware.com> <Pine.LNX.4.58.0401051001130.8705@tomservo.workpc.tds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401051001130.8705@tomservo.workpc.tds.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Lloyd <dmlloyd@tds.net>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Jan 2004, David Lloyd wrote:

> On Mon, 5 Jan 2004, Patrick Shirkey wrote:
> 
> > David Lloyd wrote:
> >
> > Recent discussion of this has made it clear that in the near future
> > Jaroslav and Takashi are planning on implementing better
> > interoperability between dmix and dsnoop.
> > 
> > It's not high on the list of priorities because there are already other
> > software mixing apps/deamons that work. It is high on the list of
> > desired features though :)
> 
> But these mixers do not work for all applications; the application has to 
> support it.  Therefore I wouldn't say they "work", becuase they do not 
> solve the problem of allowing multiple applications to use the sound 
> device without having to be coded up specially.

No and no and no. The 90% percent of problems are caused that the dmix, 
dsnoop and dshare plugins have special setup to debug / show the 
communication problems with the ALSA applications.

I am sure that most of ALSA applications work without any modification. 
Other applications are badly coded and these plugins simply show the 
problems with them. That's ok. Tell the application developers that 
they do not follow API.

OSS emulation has different problems, because their mmap() / fragment 
implementation has restrictions which are difficult to follow in some 
cases. But I think that if the buffering parameters are set correctly, 
many applications will also work.

The third major problem is rate resampling. The most of cheap cards work 
only with 48kHz. I will dig to this problem more deeply in the near 
future.

Having the mixing code in the kernel is only a new pain which does not 
solve the problem. If there's a bug in dmix, it's easy to solve it. It's 
much more easy than doing this job in the kernel.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
