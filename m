From: Paul Davis <pbd@Op.Net>
Subject: Re: Status of ALSA documentation?
Date: Fri, 15 Feb 2002 00:03:00 -0500
Message-ID: <200202150507.AAA05873@renoir.op.net>
In-reply-to: Your message of "Fri, 15 Feb 2002 14:56:11 +1000."
             <E16baPy-0005d8-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Constable <markc@renta.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I recently showed a Mac user interested in using Linux
>for live stage work (no gui needed) the ALSA site so they
>could get some idea of progress... they just laughed and
>said there was _nothing_ there to help them evaluate whether
>ALSA (therefor Linux) was going to be useful to them... well,
>not within a 5 minute perusal anyway.

i think this is an excellent, critical point.

with ALSA's adoption into the kernel, we have both (1) a chance that
more people will write HOWTOs and code but also (2) more people saying
"what is it?" and "how do i ....?" the current web site fails
completely at both tasks.

as much as i think we are still aiming for uniform operation for all
cards (i.e. they just work), i think a good place to start with
interface HOWTOs would be to take Dan's soundcard matrix, and add
links from each card name to a HOWTO. The default set of HOWTOs can be
empty, and we can add to them as time goes on. By empty, what I really
mean is a boilerplate document that says "if you have this type of
soundcard, just do X, Y, and Z and it will work". 

there should also be a way to collect card-specific bug reports and
accessing them all from the HOWTO page. 

of course a wiki would be an even better way of collecting card/setup
specific quirks, but that seems a bit much to ask for right now.

of course, it becomes critical that the matrix be kept up to date,
which could also use a wiki-style input system.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
