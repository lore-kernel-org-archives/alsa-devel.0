From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: capture buffers on SBLIVE...
Date: Sat, 29 Jun 2002 22:28:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206292224020.2593-100000@mailserver.intern.bfad.de>
References: <3D1E09F4.46DDF834@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D1E09F4.46DDF834@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 29 Jun 2002, Joern Nettingsmeier wrote:

> i'm tracking down a nasty problem i have with jack. is there any way to
> increase the periods-per-hardware-buffer setting on an sblive for
> capture ? jackd refuses to do that, and i wonder whether it's a hardware
> limitation.

I had similar problem with cs4281 driver. I had to port forward an old patch
for 0.5.12 driver to increase this.

The problem is that if the hardware supports just "buffer full" and "half
full" than it is easiest to implement just 2 periods. Getting more requires
more intelligent interrupt handler.

Look into the source code for your driver. May be you will find a place where
this limit is enforced.

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
