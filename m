From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: Re: alsamixer issues?
Date: Wed, 13 Mar 2002 07:54:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a6nfsg$lpi$2@main.gmane.org>
References: <3C8F0438.5080504@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Chris Wenn <prismatic7@bigpond.com>
Cc: Alsa-User List <alsa-user@lists.sourceforge.net>, Alsa-Devel List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Chris Wenn wrote:
> 
> Can anyone give me a hand with the following problem?
> 
> I installed a new 2.4.18 kernel image today, upgrading from my 2.4.17
> image. After I installed this, alsa broke, refusing to load at
> boot-time, claiming that the alsa driver could not be found. This
> required a full re-compile and install of alsa.

I think that anytime you change kernels alsa needs to be recompiled
because it has to be able to resolve the symbols of the currently
running kernel.

> 
> I have compiled and installed the alsa 0.9.0beta12 drivers, libraries
> and utilities as instructed in the INSTALL files for each package
> (including ./snddevices) but cannot get alsamixer to run. Whenever I
> invoke it, I get the following error
> 
> #alsamixer: function_snd_ctl_open failed for default: No such file or
>         directory

This sounds like the driver has not been loaded...

> 
> amixer gives the following, slightly different message
> 
> #amixer: Mixer attach default error: No such file or directory

looks like the same problem.

> 
> This isn't a permissions problem, as the same happens when I am logged
> in as root. The alsa drivers for my sound card (snd-card-es1968 -
> Terratec SoundSystem DMX) are loaded on bootup, so they're not lost in
> the mess. What the sam hell is going on?
> 

shouldn't snd-card-es1968 be snd-es1968 now? What version of alsa were
you using before? how are you loading the drivers at boot-up

> Chris
> 

-Eric Rz.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
