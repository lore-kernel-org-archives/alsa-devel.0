From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Problem compiling for linux 2.6
Date: Thu, 29 Jan 2004 23:08:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040129230836.325d8c2c.pochini@shiny.it>
References: <20040129001416.08a55e76.pochini@shiny.it>
	<s5hy8rqswmx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8rqswmx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Jan 2004 14:38:14 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> note that --with-isapnp is ignored on 2.6 kernel.
> the isapnp support depends only on the kernel itself.

Ok, I used that option only to avoid compiling useless stuff.

> does the attached patch work?

Yes it works. I compiled the modules successfully, after a few minor
changes to my code. Thanks.

It only complains about SUBDIRS, but it seems harmless:

  Building modules, stage 2.
/home/Giu/l26/scripts/Makefile.modpost:17: *** Uh-oh, you have stale module entries. You messed with SUBDIRS,
/home/Giu/l26/scripts/Makefile.modpost:18: do not complain if something goes wrong.
  MODPOST



--
Giuliano.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
