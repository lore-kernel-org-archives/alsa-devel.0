From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 11:21:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8772BB.F7F91C4E@sun.com>
References: <Pine.LNX.4.21.0209172012260.612-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks - Juergen just pointed out a hack to me: define LD_PRELOAD=libasound.so .
It works fine - until I'll be able to use Jaroslav's fix. Thanks Jaroslav, too!

Florian


Tim Goetze wrote:
> 
> Florian Bomers wrote:
> 
> >On the practical side - how can I solve the problem ? I can't change the way my
> >plugin is linked to the main app, so do I need to manually dlopen() libasound
> >myself with the RTLD_GLOBAL flag (and not use -lasound ??)
> 
> until your copy of alsa has jaroslav's recent addition, both. after,
> -lasound should do.
> 
> tim
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: AMD - Your access to the experts
> on Hammer Technology! Open Source & Linux Developers, register now
> for the AMD Developer Symposium. Code: EX8664
> http://www.developwithamd.com/developerlab
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
