From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: poll() and select()
Date: Wed, 15 Oct 2003 16:36:38 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031015213638.GB32391@dbz.icequake.net>
References: <20031013105324.637917b0.rpav@mephle.com> <s5h4qycup1q.wl@alsa2.suse.de> <20031014113031.7fde9794.rpav@mephle.com> <20031015010559.GA15113@dbz.icequake.net> <20031014194105.469f8da7.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031014194105.469f8da7.rpav@mephle.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

On Tue, Oct 14, 2003 at 07:41:05PM -0700, Ryan Pavlik wrote:
> On Tue, 14 Oct 2003 20:06:00 -0500
> Ryan Underwood <nemesis-lists@icequake.net> wrote:
> 
> > Silly question, but is 'npfd' the file descriptor you are polling + 1?
> 
> I AM DUMB.
> 
> I totally overlooked this.  Simple fix, and it works great.
> Thanks. :-)  You'd think I had never done this before.

I guess there is after all some benefit to asking the silly question
from time to time... ;)  At least, I know I also made that particular
stupid mistake in past code.

Good luck!

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
