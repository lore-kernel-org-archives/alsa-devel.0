From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 08:39:26 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D874CAE.DDA03E51@sun.com>
References: <E17rJn3-0005Ec-00@zaphod.blackdown.de> <87ptvcejnr.fsf@zaphod.blackdown.de>
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
To: alsa-devel@lists.sourceforge.net
Cc: Tim Goetze <tim@quitte.de>
List-Id: alsa-devel@alsa-project.org

Thanks ! I guess Juergen's suggestion would be of general: a plugin should be
able to link to libasound with -lasound without the need that the plugin itself
is linked/dlopen()'ed with RTLD_GLOBAL. With increasing adoption of ALSA, we'll
see such a scenario more and more...

On the practical side - how can I solve the problem ? I can't change the way my
plugin is linked to the main app, so do I need to manually dlopen() libasound
myself with the RTLD_GLOBAL flag (and not use -lasound ??)

Thanks,
Florian


Juergen Kreileder wrote:
> 
> Paul Davis <pbd@op.net> writes:
> 
> >>Paul Davis <pbd@op.net> writes:
> >>
> >>> the problem is that libasound itself calls dlopen(), and the
> >>> initial (non-RTLD_GLOBAL) linkage hasn't put libasound's symbol
> >>> into the global namespace. hence, libasound's own dlopen'ed code
> >>> can't access libasound itself.
> >>
> >>I know, that's why I suggested to not do dlopen(NULL, ...) inside
> >>libasound (see the code from my previous mail).
> >
> > how does this help?
> 
> You don't have to use RTLD_GLOBAL when dlopening libasound.so or
> libraries linked with libasound.so anymore.
> 
>         Juergen
> 
> --
> Juergen Kreileder, Blackdown Java-Linux Team
> http://www.blackdown.org/java-linux/java2-status/
> 
> -------------------------------------------------------
> Sponsored by: AMD - Your access to the experts on Hammer Technology!
> Open Source & Linux Developers, register now for the AMD Developer
> Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
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
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
