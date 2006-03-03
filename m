From: Jim Gleason <jgleason@helius.com>
Subject: Re: 1.0.11rc3 on 2.4.19 on old Caldera
Date: Fri, 03 Mar 2006 12:52:53 -0700
Message-ID: <1141415573.6137.40.camel@jmg.helius.com>
References: <1141335345.6126.25.camel@jmg.helius.com>
	 <20060303073604.GC8569@turing.informatik.uni-halle.de>
	 <1141404684.6137.29.camel@jmg.helius.com>  <s5hbqwno1x9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbqwno1x9.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Added acpi=off to LILO and rebooted.
/var/log/messages indicates "ACPI: disabled by cmdline, exiting"

No change in audio behavior.

Jim Gleason

On Fri, 2006-03-03 at 18:47 +0100, Takashi Iwai wrote:
> At Fri, 03 Mar 2006 09:51:24 -0700,
> Jim Gleason wrote:
> > 
> > > > In /proc/interrupts, I get no or very limited interrupt action.
> > > 
> > > Looks like the interrupt isn't configured correctly.  Try enabling or
> > > disabling ACPI.
> > *** The following is from our .config file
> > CONFIG_HOTPLUG_PCI_ACPI=m
> > .
> > .
> > CONFIG_ACPI=y
> > # CONFIG_ACPI_DEBUG is not set
> > CONFIG_ACPI_BUSMGR=m
> > CONFIG_ACPI_SYS=m
> > CONFIG_ACPI_CPU=m
> > CONFIG_ACPI_BUTTON=m
> > CONFIG_ACPI_AC=m
> > CONFIG_ACPI_EC=m
> > CONFIG_ACPI_CMBATT=m
> > CONFIG_ACPI_THERMAL=m
> > *** There are not *acpi* modules currently loaded
> 
> The irq routing is irrelvant with ACPI modules.
> Try to boot with acpi=off, for example (although I'm not sure whether
> it's in 2.4 kernel too).
> 
> 
> Takashi
> 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
