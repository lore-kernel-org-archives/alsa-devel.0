From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Docu:: Alsa Audio API:: A minimal capture program
Date: Mon, 9 Feb 2004 08:48:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402090845210.2168@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0401281614420.11576-100000@studcom.urz.uni-halle.de>
 <200401282338.25438.tmohr@s.netic.de> <Pine.LNX.4.58.0401311456180.1876@pnote.perex-int.cz>
 <200402090119.00259.tmohr@s.netic.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402090119.00259.tmohr@s.netic.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torsten Mohr <tmohr@s.netic.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Feb 2004, Torsten Mohr wrote:

> Hi,
> 
> > > thanks for that hint.
> > >
> > > But sadly, the attached program doesn't work, though
> > > i set stop_threshold to 0.  I didn't find any functions
> >
> > This is wrong. You need to set this value to sw_params->boundary or
> > greater value to eliminate the stop detection, otherwise with zero,
> > the stream is immediately stopped.
> 
> thanks again.
> 
> But this doesn't seem to be the problem, the attached file is
> basically the example "minimal capture program" with the
> suggested additions.
> 
> The program fails badly.  It would be so very great if somebody
> had a hint for me on that one.  I tried to find the source of
> the problem, but i didn't succeed.

You've made this stupid bug:

data = (unsigned char *)calloc(SAMPLES*4, 0);

should be:

data = (unsigned char *)calloc(periodsize*4, 1);

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
