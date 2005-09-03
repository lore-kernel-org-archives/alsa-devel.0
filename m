From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hdspmixer segfaults on AMD64
Date: Fri, 02 Sep 2005 20:25:39 -0400
Message-ID: <1125707139.4991.29.camel@mindpipe>
References: <5bdc1c8b050902153359513ac2@mail.gmail.com>
	 <1125706745.4991.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125706745.4991.25.camel@mindpipe>
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

On Fri, 2005-09-02 at 20:19 -0400, Lee Revell wrote:
> On Fri, 2005-09-02 at 15:33 -0700, Mark Knecht wrote:
> > Hi,
> >    I think this may possibly be fixed already but I couldn't find an
> > associated bug in Mantis. When I run hdspmixer on my AMD64 system
> > using 2.6.13-gentoo or 2.6.12-gentoo-r9 it segfaults. I'm running
> > Alsa-1.0.9 mostly:
> 
> Try ALSA 1.0.10-rc1.

Actually before you try upgrading, use gdb to get a backtrace.

$ gdb ./hdspmixer

Then when it crashes do "thread apply all bt" and post the output.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
