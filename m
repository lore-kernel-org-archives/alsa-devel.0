From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: mutli channel
Date: Sun, 02 Feb 2003 15:26:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18fQd3-0000nw-00@sc8-sf-list1.sourceforge.net>
References: <200302011222.49280.ljp@llornkcor.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 01 Feb 2003 12:22:49 MST."
             <200302011222.49280.ljp@llornkcor.com>
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

>1) does alsa have support for multichannel output? If so, how would one go 

of course.

>about sending individual signals to channels 1-8?

depends on the access format: interleaved or non-interleaved. it also
depends on whether you are using read/write access or mmap-based
access. 

so you have to get a bit more specific with your question before we
can answer it.

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
