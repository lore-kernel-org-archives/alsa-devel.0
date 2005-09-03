From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hdspmixer segfaults on AMD64
Date: Fri, 02 Sep 2005 21:34:54 -0400
Message-ID: <1125711294.4991.35.camel@mindpipe>
References: <5bdc1c8b050902153359513ac2@mail.gmail.com>
	 <1125706745.4991.25.camel@mindpipe>
	 <5bdc1c8b050902172552be43d1@mail.gmail.com>
	 <1125707279.4991.33.camel@mindpipe>
	 <5bdc1c8b05090217476fe9ba06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b05090217476fe9ba06@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-09-02 at 17:47 -0700, Mark Knecht wrote:
> On 9/2/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-09-02 at 17:25 -0700, Mark Knecht wrote:
> > > Hi Lee,
> > >    I downloaded alsa-tools-1.0.10-rc1 and built just the hdspmixer app
> > > from that tarball. Same segfault. I have a fairly useless (I think)
> > > back trace. I haven't figured out how to get good symbols. (I'm not a
> > > programmer - sorry!)
> > >
> > > Here's what I have so far, the important point being that it segfaults
> > > exactly like the one in 1.0.9.
> > 
> > I think you can get a better backtrace by running gdb from the source
> > directory you compiled the program in.  Also install the debug version
> > of libfltk if possible.
> > 
> > Anyway it looks like the problem is libfltk related.  Maybe try to
> > upgrade or downgrade libfltk?
> > 
> > Lee
> 
> Bingo - Upgrading fltk from 1.1.4 to 1.1.6 fixed the problem.
> hdspmixer is up. Time to hook up ADAT cables and see if this puppy
> makes noise!
> 

Wow, cool!  That was a complete shot in the dark!

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
