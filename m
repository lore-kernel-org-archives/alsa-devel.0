From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Wed, 05 Feb 2003 09:16:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18gQH9-0000Bz-00@sc8-sf-list1.sourceforge.net>
References: <20030205140357.3700.qmail@web40605.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 05 Feb 2003 14:03:57 GMT."
             <20030205140357.3700.qmail@web40605.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Sebastian Kapfer <sebastian_kapfer@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Speaking as a userspace developer, I expect file
>descriptors to be inherited by child processes unless
>I explicitly request otherwise. Yes, I usually make
>sure that I *DO* request otherwise, but that's not the
>point...

the question is not about inheritance by child processes. its about
close-on-exec behaviour. nobody is proposing any change to the
situation after a simple fork(2).

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
