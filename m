From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [BUG] alsa-lib leaves sound device open for child processes
Date: Fri, 07 Feb 2003 10:22:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18hAI3-0000eO-00@sc8-sf-list1.sourceforge.net>
References: <20030207135848.567.qmail@web40611.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 07 Feb 2003 13:58:48 GMT."
             <20030207135848.567.qmail@web40611.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> there's a little detail you're forgetting. unless
>> the hw supports multi-open and the current number of
>> subunits is below the limit of the number of opens,
>> then having the descriptor will cause all other
>> attempts to access the device to block (unless they
>> explicitly request non-blocking open, which means
>> they then have to unset that flag for normal
>> application operation
>
>I hadn't forgotten. The situation to which you are
>referring is called "a bug in the *application*".

not clearly so. there are very few resources accessed via a file
descriptor that require this being done. 

the fact that an application has to understand this only adds to the
problems with the block-on-open design.

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
