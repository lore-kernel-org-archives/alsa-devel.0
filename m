From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: porting oss app to alsa
Date: Thu, 30 Jan 2003 11:31:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2ptqfdj4l.fsf@vador.mandrakesoft.com>
References: <200301292018.47486.ljp@llornkcor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301292018.47486.ljp@llornkcor.com> (ljp's message of "Wed,
 29 Jan 2003 20:18:47 -0700")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ljp <ljp@llornkcor.com>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

ljp <ljp@llornkcor.com> writes:

> Is there a simple document outlining the OSS functions and their
> ALSA equivalents?

for basic usage : do man of open(), read(), close(), write().
this is portable but limited (open/closing mixer/device, setting mix ,
output samples, ...)

for high level usage, look at html doc in libalsa2.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
