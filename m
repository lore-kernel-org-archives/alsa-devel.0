From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 17:10:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87ptvcejnr.fsf@zaphod.blackdown.de>
References: <E17rJn3-0005Ec-00@zaphod.blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17rJn3-0005Ec-00@zaphod.blackdown.de> (Paul Davis's message
 of "Tue, 17 Sep 2002 10:59:17 -0400")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Tim Goetze <tim@quitte.de>, Florian Bomers <Florian.Bomers@sun.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis <pbd@op.net> writes:

>>Paul Davis <pbd@op.net> writes:
>>
>>> the problem is that libasound itself calls dlopen(), and the
>>> initial (non-RTLD_GLOBAL) linkage hasn't put libasound's symbol
>>> into the global namespace. hence, libasound's own dlopen'ed code
>>> can't access libasound itself.
>>
>>I know, that's why I suggested to not do dlopen(NULL, ...) inside
>>libasound (see the code from my previous mail).
> 
> how does this help?

You don't have to use RTLD_GLOBAL when dlopening libasound.so or
libraries linked with libasound.so anymore.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://www.blackdown.org/java-linux/java2-status/


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
