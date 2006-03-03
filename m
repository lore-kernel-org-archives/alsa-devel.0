From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.11rc3 on 2.4.19 on old Caldera
Date: Fri, 03 Mar 2006 08:36:04 +0100
Message-ID: <20060303073604.GC8569@turing.informatik.uni-halle.de>
References: <1141335345.6126.25.camel@jmg.helius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1141335345.6126.25.camel@jmg.helius.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jim Gleason <jgleason@helius.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jim Gleason wrote:
> I am having trouble getting a Soundblaster live 24-bit to work.  I have
> built 1.0.11rc3 (drivers, libs, utils) on a 2.4.19 kernel running on a
> very old Caldera system with limited updates (the card worked fine on my
> debian/testing machine).  (I don't have a choice on the system.)  I had
> to modify the /etc/rc.d/init.d/alsasound and /usr/sbin/alsaconf scripts
> to work with very old versions of bash and grep. When I enter aplay as
> follows:
> 
> aplay  -Dplug:cards.pcm.default -f S32_LE -c2 -r44100 /dev/urandom

Why don't you just use -Ddefault?

What are the contents of /proc/asound/cards and
/proc/asound/card0/pcm0p/sub0/hw_params?

> In /proc/interrupts, I get no or very limited interrupt action.

Looks like the interrupt isn't configured correctly.  Try enabling or
disabling ACPI.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
