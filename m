From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Ctl events problem
Date: Mon, 7 Mar 2005 14:56:32 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503071451440.1751@pnote.perex-int.cz>
References: <20050306180252.22b03da3.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050306180252.22b03da3.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 6 Mar 2005, Giuliano Pochini wrote:

> I'm updating echomixer to make it take into account control events. It
> works well, but I have a problem with a "virtual" control. Some cards
> work this way:
> 
> Inputs ----> monitor mixer ----
>                                \
>                                 >----> line-out volume ----> Outputs
>                                /
> PCM -------> PCM volume -------
> 
> But some cards do not have the line-out volume control and since it's a
> very handy feature echomixer emulates it by changing both PCM playback
> volume and monitor mixers according to the setting of the virtual
> line-out control. The problem is ALSA does not deliver events of that
> non-existent control... because it doesn't exist. It delivers events of
> PCM vol and mmixer instead, which is exactly the opposite of what I
> need. One possible solution is to move all that emulation stuff into the
> driver :-6 Otherwise is it possible to write a plugin for alsa-lib that
> does the emulation for cards that require it ?  (docs ?)  Other ideas ?

You can create a new "user space" control in your application. Then the
driver will notify about changes the other apps, too. See the pcm_softvol.c
code for more details...

But yes, it's something to be resolved in alsa-lib, unfortunately, my work 
on alisp is slow due to various maintenance..

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
