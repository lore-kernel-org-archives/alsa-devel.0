From: Paul Davis <pbd@op.net>
Subject: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 10:59:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rJn4-0006ys-00@usw-sf-list1.sourceforge.net>
References: <87vg54ekrp.fsf@zaphod.blackdown.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 17 Sep 2002 16:46:50 +0200."
             <87vg54ekrp.fsf@zaphod.blackdown.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Tim Goetze <tim@quitte.de>, Florian Bomers <Florian.Bomers@sun.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Paul Davis <pbd@op.net> writes:
>
>> the problem is that libasound itself calls dlopen(), and the initial
>> (non-RTLD_GLOBAL) linkage hasn't put libasound's symbol into the
>> global namespace. hence, libasound's own dlopen'ed code can't access
>> libasound itself.
>
>I know, that's why I suggested to not do dlopen(NULL, ...) inside
>libasound (see the code from my previous mail).

how does this help?


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
