From: Justin Cormack <justin@street-vision.com>
Subject: Re: alsa and gtk
Date: 08 Jun 2003 19:10:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055095801.17291.17.camel@lotte>
References: <1055071787.418.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055071787.418.9.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-06-08 at 12:29, David E. Storey wrote:
> folks,
> 
> thought I'd bounce this off the list in case anyone has seen it before.
> I'm trying to write something like TotalMix for the RME HDSP, but more
> suited for mixing in-ear-monitors. So I wrote this mini library that
> uses the snd_ctl_* api of alsa. Wrote all the functionality, tested the
> functionality in a CLI and everything worked. Yesterday, I started
> writing the GUI in GTK and some weird things started happening. Whenever
> I tried using the library outside of gtk_main, everything worked fine.
> It wasn't until after I started using snd_ctl_* functions from within
> gtk callbacks that I was having issues. If I move the library calls
> outside of something within  or before gtk_main, it works just fine.
> After calling gtk_main, any functions are also toast. When trying to
> write to a control element, I get:
> 
> Control hw:1 element write error: No such file or directory
> 
> and similarly, when I try to read an element, I get:
> 
> Control hw:1 element read error: No such file or directory
> 
> Once gtk_main hits, the game is over. Is there something gtk_main does
> to the environment that affects alsa? I'm willing to post code for
> anyone who's interested. Normally, I'd start pouring through GTK+ and
> Alsa source at this point, but time is of the essence in my case.

I had a problem like this once, not with gtk. The controls  get
corrupted. I had an extrmemely short deadline so I just allocated and
freed a new control every time I wanted to use it, rather inefficient. I
think it *must* be an alsa bug, but it is very strange. Hope you can
find it. 

Justin




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
