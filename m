From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Fri, 14 Nov 2003 07:21:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com>
References: <200311140246.14873.pwk.linuxfan@gmx.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 14 Nov 2003 02:43:37 +0100."
             <200311140246.14873.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>So, these are two numbers - and basicly all is fine as long as you dont wan=
>t=20
>to excede them, but if you do, you need to use dmix or dsnoop. Why not use=
>=20
>dmix and dsnoop automaticly when necessary ? Wouldnt it be possible to have=

because it would be catastrophic, or, well, at least very bad, for
applications that want to "sit close to the metal".

this is a user-space configuration issue, not something that alsa-lib
should do by default. if the user (or the distributor) defines "dmix"
to be the default device type, then every conformant ALSA application
will do the right thing. apps like JACK that want to "site close to
the metal" will still use "hw:N" unless you tell it otherwise, but
consumer apps will use "default" (that's what i mean by conformant)
and get dmix behaviour.

--p



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
