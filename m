From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 15:43:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271541100.532-100000@pnote.perex-int.cz>
References: <20021127135012.7B5A559D353@kerberos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021127135012.7B5A559D353@kerberos.suse.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: tomasz motylewski <T.Motylewski@bfad.de>, James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Paul Davis wrote:

> >This is my personal preference. In this model the only service ALSA has to
> >supply are:
> >
> >1. initial configuration/start/stop.
> >2. mmapable DMA buffer
> >3. fact and precise ioctl telling the current HW pointer in the buffer. If the
> >card is not queried each time, then the "last period interrupt" timestamp
> >should be included.
> 
> ALSA supplies all 3 of these. You can use them by themselves without
> the rest of the API if you want. The only problem arises with hardware
> that cannot give you accurate h/w pointer positions.
> 
> >Please stop the complication of "available/delay" etc. Just the raw
> >pointer.  Each application knows where its application pointer is, so
> >it can easily calculate delay/available and decide for itself whether
> >there was an overrun or not.
> 
> actually, it can't. if the user space application is delayed for
> precisely 1 buffer's worth of data, it will see the pointer at what
> appears to the the right place and believe that no xrun has
> occured. the only way around this is to provide either:
> 
> 	* h/w pointer position as a steadily incrementing value
> 	* h/w pointer position *plus* interrupt count
> 
> i favor the latter since it provides for a longer time before wrapping
> becomes an issue (ULONG_MAX interrupts).

The ALSA internal code already uses hw_ptr and appl_ptr within range 0 to
boundary, where boundary is close to ULONG_MAX and expression boundary / 
period_size == an integer value. So, the hardware pointer also contains 
count of hardware interrupts as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
