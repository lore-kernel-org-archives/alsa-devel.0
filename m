From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: OpenAL- ALSA advanced features hardware support
	update.
Date: Mon, 22 Dec 2003 02:44:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072075466.3072.8.camel@localhost>
References: <1072063439.1803.31.camel@localhost>
	 <20031222023843.GE7080@zewt.org>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031222023843.GE7080@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <glenn@zewt.org>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-12-21 at 22:38, Glenn Maynard wrote:
> On Sun, Dec 21, 2003 at 11:24:00PM -0400, Manuel Jander wrote:
> > The same as for the first iteration of this proposal, please take some
> > minutes and give some comments/suggestions back. I need feedback.
> 
> I'll give some higher level feedback:  Why OpenAL?  

Do you know about any other alternative ?? I don't.

> I looked at it about a year ago, while rewriting the sound system for
> a game with relatively strict sound demands. (StepMania; we wanted
> hardware mixing, when possible, and sound-to-gameplay sync to be as
> tight as possible, within a couple ms).
> 
> I couldn't find any active mailing lists.  I couldn't even find any
> indication that anyone was working on it at all.  I read some of the
> Windows source code, and saw what is--without exaggeration--some of
> the most heinous, seizure-inducing code I've ever seen.  (There were
> conditionals and loops nested something like 12 levels deep.  I don't
> think the programmer understood the concept of the "return" keyword.)
> 
> And although the API was decent to look at, it had no way of getting an
> accurate hardware play cursor, or any other mechanism to get a good idea
> of the currently-playing sample (for eg. graphical sync).  We couldn't
> reliably sync sound with any smaller resolution than a whole buffer.
> 
> I don't think OpenAL has a future.  Do you really want to invest your time
> in it?

I agree that the implementation isn't the best. But its not about the
particular implementation. Its about standards. If you look at OpenAL,
its mostly a imitation of Aureals A3D. Some name changed, but in essence
just like A3D, most of its look and feel (of the API) has been borrowed
from OpenGL.

For know i don't have the time to write a new library and pretend it to
be adopted widespread by others. If we support OpenAL, the
implementation may be improved, once it is working.

Best Regards.

Manuel Jander




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
