From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: porting oss app to alsa
Date: Thu, 30 Jan 2003 09:29:27 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18eFdy-00047R-00@sc8-sf-list1.sourceforge.net>
References: <200301300717.36415.ljp@llornkcor.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 30 Jan 2003 07:17:36 MST."
             <200301300717.36415.ljp@llornkcor.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ljp <ljp@llornkcor.com>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I am asking this, as the ALSA OSS compat. seems to be getting depreaciated (I 
>dont blame it), and stuck on rc1.

its not deprecated, though many of us would actively discourage anyone
from writing new applications that use the OSS API. its very important
for ALSA that it fully and properly supports the OSS API. if it did
not, it would have been very hard to get linus to accept ALSA as the
default/standard audio API in the 2.5/2.6 kernel series.

--p

ps. of course, some of us would discourage people from using ALSA 
    as the API too :)))


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
