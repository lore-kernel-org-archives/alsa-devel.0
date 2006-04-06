From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Cross compiling alsa-driver
Date: Thu, 06 Apr 2006 23:29:04 +0100
Message-ID: <1144362544.9219.14.camel@localhost.localdomain>
References: <1144187819.9472.25.camel@localhost.localdomain>
	 <s5hwte4ntxt.wl%tiwai@suse.de>
	 <1144361810.9219.6.camel@localhost.localdomain>
	 <1144362329.12038.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144362329.12038.22.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-04-06 at 18:25 -0400, Lee Revell wrote:
> On Thu, 2006-04-06 at 23:16 +0100, Adrian McMenamin wrote:
> > checking for directory with kernel
> > source... /home/adrian/linux-2.6.15.2
> > checking for directory with kernel
> > build... /home/adrian/linux-2.6.15.2 
> 
> It's not ignoring them.  It sounds like you just need to add aica to the
> build scripts.
> 
> What is the output of "grep aica ./configure"?
> 


I know that aica isn't in there - but the general build should still
work and it doesn't...

make[2]: Leaving directory `/home/adrian/alsa-driver-1.0.11rc4/pci'
make[1]: Leaving directory `/home/adrian/alsa-driver-1.0.11rc4'
make -C /lib/modules/2.6.12-10-686/build
SUBDIRS=/home/adrian/alsa-driver-1.0.11rc4 O=/home/adrian/linux-2.6.15.2
modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.12-10-686'
/usr/src/linux-headers-2.6.12-10-686/Makefile:530: /usr/src/linux-headers-2.6.12-10-686/arch//Makefile: No such file or directory
/bin/sh: /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc-3.4: No such file or directory
make[2]: *** No rule to make target
`/usr/src/linux-headers-2.6.12-10-686/arch//Makefile'.  Stop.
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.12-10-686'




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
