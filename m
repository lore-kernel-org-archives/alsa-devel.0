From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: status of powermac sound?
Date: Wed, 12 May 2004 10:18:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040512101801.pochini@shiny.it>
References: <200405121138.09878.bergtroll@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405121138.09878.bergtroll@gmx.li>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Niklas Werner <bergtroll@gmx.li>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 11-May-2004 Niklas Werner wrote:
> Hi *,
>
> is there any progress on the status of full support for the newer devices
> as snapper, etc (in the AlBooks,..). I'm running the 2.6.5 benh-kernel
> from bitkeeper and basically the sound only works reliably when using the
> oss emulation.

I have a G4-MDD (snapper) and the last time I tested it the sound worked
fine only if the buffer is a power of 2 and periods are an exact
submultiple, otherwise it skips. Furthermore it tends to distort as soon
as I raise the volume and it happes at a level lower than OSX. I'll do
more testing if it can help.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
