From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Re: Alsa-devel digest, Vol 1 #1207 - 14 msgs
Date: Wed, 4 Jun 2003 11:24:16 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306041124.16908.n8gray@caltech.edu>
References: <E19NYdu-0004A9-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19NYdu-0004A9-00@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: markknecht@attbi.com
List-Id: alsa-devel@alsa-project.org

On Wednesday 04 June 2003 06:48 am, 
alsa-devel-request@lists.sourceforge.net wrote:
> Florian,
>    Yes. Thanks. This is something Jaroslav pointed out later in the
> morning. With this strategy I got at least a simple alsa application
> to play sounds cleanly, so this was helpful.
>
>    Can you shed any light on getting a game like frozen-bubble to use
> Alsa? When I try to start this app it lock up with error messages
> about resources being busy.

That means that some other program is using the soundcard (only one 
program at a time can use it).  If you're running KDE then ARTS is a 
likely suspect and you can try running "artsdsp frozenbubble".  
Otherwise you can try "fuser /dev/dsp" or "fuser /dev/snd/pcmC0D1p" to 
find out the PID of the process that's using it.

Someday the dmix plugin might be usable in which case this problem will 
go away.

>    Am I correct in guessing that an app like frozen-bubble is using
> the OSS portion of Alsa? Is there some setup that I can do to point
> OSS sound requests to this default device?

That's pretty much automatic.  There's nothing you need to do.

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
