From: Mark Knecht <markknecht@attbi.com>
Subject: Re: Re: Alsa-devel digest, Vol 1 #1207 - 14 msgs
Date: 04 Jun 2003 12:45:27 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054755927.10453.12.camel@Wizard.knechthome.com>
References: <E19NYdu-0004A9-00@sc8-sf-list2.sourceforge.net>
	 <200306041124.16908.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306041124.16908.n8gray@caltech.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nathaniel Gray <n8gray@caltech.edu>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-06-04 at 11:24, Nathaniel Gray wrote:
> On Wednesday 04 June 2003 06:48 am, 
> alsa-devel-request@lists.sourceforge.net wrote:
> > Florian,
> >    Yes. Thanks. This is something Jaroslav pointed out later in the
> > morning. With this strategy I got at least a simple alsa application
> > to play sounds cleanly, so this was helpful.
> >
> >    Can you shed any light on getting a game like frozen-bubble to use
> > Alsa? When I try to start this app it lock up with error messages
> > about resources being busy.
> 
> That means that some other program is using the soundcard (only one 
> program at a time can use it).  If you're running KDE then ARTS is a 
> likely suspect and you can try running "artsdsp frozenbubble".  
> Otherwise you can try "fuser /dev/dsp" or "fuser /dev/snd/pcmC0D1p" to 
> find out the PID of the process that's using it.
> 
> Someday the dmix plugin might be usable in which case this problem will 
> go away.

Nathanial,
   Hi. Thanks for the ideas. While I know it's not practical for you to
have gone back and reread all the the traffic on this over the last week
or two, I think this answer, while technically correct, possibly doesn't
apply in this case:

1) As I've reported, I'm running fluxbox which has no specific sound
support, servers, etc., to the best of my knowledge. There is certainly
nothing obvious when looking at processes. I've used Alsa under both
Gnome and KDE, so I am familiar with these potential problems. 

2) The single application answer would apply to other Alsa apps, like
aplay also. However, I can run aplay multiple times before I run
frozen-bubble, and I can run it immediately after killing frozen-bubble
after the hand. If some other application was using Alsa, and blocking
frozen-bubble, then I would expect it to block ALL other Alsa apps, and
not just frozen-bubble.


> 
> >    Am I correct in guessing that an app like frozen-bubble is using
> > the OSS portion of Alsa? Is there some setup that I can do to point
> > OSS sound requests to this default device?
> 
> That's pretty much automatic.  There's nothing you need to do.

Probably true, but I was told that using aplay would be automatic also,
and it wasn't. I've had to associate a pcm.!default entity to get it to
work, so something is not quite right. I continue to wonder if something
similar is effecting the OSS part of this machine.

I will have to look into the fuser idea. It sounds interesting.
Currently I have a different sound card loaded and this problem does not
appear. I'll have to load up the Via driver and try this out.

None the less, thanks for your insights. I will continue to look for the
answer, but this is software and I am blind.

With best regards,
Mark



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
