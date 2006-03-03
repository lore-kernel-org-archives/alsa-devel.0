From: Jim Gleason <jgleason@helius.com>
Subject: Re: [Alsa-devel] 1.0.11rc3 on 2.4.19 on old Caldera
Date: Fri, 03 Mar 2006 09:51:24 -0700
Message-ID: <1141404684.6137.29.camel@jmg.helius.com>
References: <1141335345.6126.25.camel@jmg.helius.com>
	 <20060303073604.GC8569@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <20060303073604.GC8569@turing.informatik.uni-halle.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Responses/comments embedded below.

Jim Gleason

On Fri, 2006-03-03 at 08:36 +0100, Clemens Ladisch wrote:
> Jim Gleason wrote:
> > I am having trouble getting a Soundblaster live 24-bit to work.  I have
> > built 1.0.11rc3 (drivers, libs, utils) on a 2.4.19 kernel running on a
> > very old Caldera system with limited updates (the card worked fine on my
> > debian/testing machine).  (I don't have a choice on the system.)  I had
> > to modify the /etc/rc.d/init.d/alsasound and /usr/sbin/alsaconf scripts
> > to work with very old versions of bash and grep. When I enter aplay as
> > follows:
> > 
> > aplay  -Dplug:cards.pcm.default -f S32_LE -c2 -r44100 /dev/urandom
> 
> Why don't you just use -Ddefault?
No particular reason - Just trying to eliminate anything that might play
a role in the problem.
> 
> What are the contents of /proc/asound/cards and
> /proc/asound/card0/pcm0p/sub0/hw_params?
> 
[11:44:20 root@ccs /root]# cat /proc/asound/cards
 0 [CA0106         ]: CA0106 - CA0106
                      Live! 7.1 24bit [SB0410] at 0xcc80 irq 27
[11:44:28 root@ccs /root]#
[11:44:30 root@ccs /root]# cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 8192
tick_time: 10000
[11:44:52 root@ccs /root]#
> > In /proc/interrupts, I get no or very limited interrupt action.
> 
> Looks like the interrupt isn't configured correctly.  Try enabling or
> disabling ACPI.
*** The following is from our .config file
CONFIG_HOTPLUG_PCI_ACPI=m
.
.
CONFIG_ACPI=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m
*** There are not *acpi* modules currently loaded
> 
> HTH
> Clemens
> 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
