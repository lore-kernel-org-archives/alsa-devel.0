From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: About integer64
Date: Thu, 9 May 2002 12:37:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205091235360.482-100000@pnote.perex-int.cz>
References: <3CDA2EE2.A3C6D824@alsa-project.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CDA2EE2.A3C6D824@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Paul Davis <pbd@Op.Net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 May 2002, Abramo Bagnara wrote:

> 
> I don't think that's a bad thing to have support for 64 bit integers
> (perhaps for future use, who knows), but I think that to use this to
> store a fixed point float is a big mistake.
> 
> If you think for it you realize that it's *not* an integer and
> applications are betrayed in their expectation.
> 
> I see two possible solutions:
> 1) convert internal representation to float (or double) and add support
> for this type of data
> 2) use SNDRV_CTL_ELEM_TYPE_BYTES
> 
> As I've already said I prefer 1) but too 2) is far better that to have a
> wrong use of a data type.

I fully agree. We can add a float type when necessary, but only when it
follows IEEE-754. Hardware specific formats should be encapsulated into
more generic types...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
