From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: periods? fragments?
Date: Mon, 19 May 2003 10:12:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305191011450.21997-100000@pnote.perex-int.cz>
References: <XFMail.20030519100425.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20030519100425.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: David Stuart <dave@sipquest.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 19 May 2003, Giuliano Pochini wrote:

> 
> On 19-May-2003 David Stuart wrote:
> > Greetings! Fledgeling alsa developer here,
> >
> > After reading a bunch of documentation, it's unclear to me exactly what
> > a period/fragment is used for. Could anyone expand on it a bit to fill
> > me in?
> 
> You need an audio buffer to send/receive data from the audio
> chip. The buffer is made of two or more periods.

Note really. One fragment can be used too. In that case, application must 
do timing itself (using an external timer).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
