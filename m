From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Possible solution for the alsa-oss fopen problem.
Date: Thu, 10 Jun 2004 14:09:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040610140943.2d11d904@mango.fruits.de>
References: <40C6F035.4000406@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40C6F035.4000406@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 09 Jun 2004 12:10:45 +0100
James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> I have found out that the artsdsp /dev/oss redirector supports fopen and 
> friends.
> I looked at the artsdsp, (find it inside arts-1.2.2.tar.bz2)
> It uses a function called fopencookie()
> 
> Extract from /arts-1.2.2/artsc/stdioemu.c below.
> 
> Would this be useable in the alsa-oss redirector?

This fopencookie seems to be a libc thing to implement custom streams.. See

http://wwwwbs.cs.tu-berlin.de/user-taipan/kraxel/gnuinfo/libc/Streams_and_Cookies.html

Might be exctly the thing which is needed to intercept fopen() and friends AND handle the intercepted calls gracefully..

I have a question though: If this works for alsa-oss, then the libc problem with the internal symbols of open() and friends is solved. But i wonder if there are any other libs which are as "evil" in this regard as libc is. The basic problem persists: If a lib uses internal symbols for open() and friends and an app uses that lib to access /dev/dsp, etc., then we're screwed again..

On the other hand: How many libs besides libc do stuff like this? And how many apps use such a lib? I would guess: very very few.. If this is the case, i suppose it will work well (tm)

Florian Schmidt

-- 
Palimm Palimm!



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
