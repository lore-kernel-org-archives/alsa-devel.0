From: "David E. Storey" <dave@tamos.net>
Subject: Re: dsnoop
Date: Fri, 16 May 2003 20:59:19 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0305162052380.26455@grue.tamos.net>
References: <E19Gmd1-00018k-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19Gmd1-00018k-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


When I don't specify a duration, it writes a frame of audio and
terminates. Not terribly useful. Not sure if this is the normal mode of
operation, but it doesn't meet my criteria for sure. I need to be able to
record indefinitely. (which, of course, depends on storage capacity.)

d!

On Fri, 16 May 2003, Paul Davis wrote:

> >Would anyone be so kind as to offer up an example of using dsnoop? I'd
> >like to use jack to perform all kinds on monitoring on a device and use
> >an alsa app, namely arecord, to do the actual recording. I've tried
> >using the jack plugin and while it works, when I hit CTRL-C on arecord
> >to stop recording, it pretty much halts jack.
>
> just as a matter of interest, why not use the jack capture client?
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: If flattening out C++ or Java
> code to make your application fit in a relational database is painful,
> don't do it! Check out ObjectStore. Now part of Progress Software.
> http://www.objectstore.net/sourceforge
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
