From: Jon <jcb@niluge.net>
Subject: Re: Unexpected hw_pointer value
Date: Tue, 7 Oct 2003 00:33:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031006223344.GA589@zeus.homenet>
References: <20031004211200.GA13137@zeus.homenet> <20031004215812.GI2972@dbz.icequake.net> <20031005162648.1e15ace5.pochini@shiny.it> <Pine.LNX.4.53.0310061419200.1641@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0310061419200.1641@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Giuliano Pochini <pochini@shiny.it>, Ryan Underwood <nemesis-lists@icequake.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 06 October, 2003 � 03:36:32PM +0200, Jaroslav Kysela wrote:
> We added these sanity checks for debugging purposes, but if they occur too
> much, there's something bad with driver or hardware.
> 
> Basically, we have only information from last interrupt position and the
> actual position in the ring buffer. We need to determine the new
> "absolute" position. To detect the wrap point, we compute the delta value
> for the new and old position and if delta is greater than buffer_size / 2,
> we correct the new position by adding buffer_size. Otherwise we take value
> as error, because we ask driver to acknowledge interrupts after
> period_size not before. Note that some interrupt might be lost.
> 
> 						Jaroslav

my hardware seems really bad : ES1983S Maestro-3i on a dell c600.
i experience lots of hardware freeze (bios does not respond) caused the
driver/card with oss or alsa.

i'm kind of desperate with my sound card :(


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
