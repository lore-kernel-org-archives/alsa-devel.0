From: Justin Cormack <justin@street-vision.com>
Subject: Re: alsa and gtk
Date: 09 Jun 2003 13:53:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055163238.17310.52.camel@lotte>
References: <1055071787.418.9.camel@localhost>
	<1055095801.17291.17.camel@lotte>  <1055106176.875.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055106176.875.1.camel@localhost>
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

If you still have the non working version it might be worth running it
under valgrind to see if you can find where the bug is, as it would be
nice to fix it. Or send me a copy and I will have a go. I dont have the
old version of my code, though I could reconstruct it.


On Sun, 2003-06-08 at 22:02, David E. Storey wrote:
> curious... that did the trick. True about the inefficiency... but then
> again, we are talking about GUI's. ;-) Thanks!
> 
> d!
> 
> On Sun, 2003-06-08 at 14:10, Justin Cormack wrote:
> > I had a problem like this once, not with gtk. The controls  get
> > corrupted. I had an extrmemely short deadline so I just allocated and
> > freed a new control every time I wanted to use it, rather inefficient. I
> > think it *must* be an alsa bug, but it is very strange. Hope you can
> > find it. 
> 




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
