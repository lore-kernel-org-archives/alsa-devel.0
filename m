From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 14:14:07 -0500
Message-ID: <200411151914.iAFJE79w014546@localhost.localdomain>
References: <Pine.LNX.4.58.0411151859220.9516@zeus.compusonic.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 15 Nov 2004 19:31:23 +0200."
             <Pine.LNX.4.58.0411151859220.9516@zeus.compusonic.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> It's (and was) a broken idea. We have never ending trouble to reroute your
>> API to ours, because you have not designed a proper library in the user
>> space to handle application requests.
>Interesting point. Do you mean that all Linux drivers for whatever devices
>should have defined their own library interface instead of the using the
>traditional Unix device/file interface?

No, Jaroslav doesn't mean that and you know it. But take a look at
video devices for a comparison. There is almost no application for any
Unix system that accesses the video device directly. X, libsvga (or
whatever its called), OpenGL ... video programs use abstractions that
are supported by libraries that sit on top of device drivers.

And there very good reasons for this - many manufacturers of
frequently incompatible hardware, often designed around quite
different h/w models. As soon as we moved away from VGA-style video
(the audio equivalent, of course, being the soundblaster), everybody
on every OS i can think of moved to video access via a library. 

--p


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
