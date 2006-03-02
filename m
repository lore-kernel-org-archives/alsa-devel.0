From: Jim Gleason <jgleason@helius.com>
Subject: 1.0.11rc3 on 2.4.19 on old Caldera
Date: Thu, 02 Mar 2006 14:35:44 -0700
Message-ID: <1141335345.6126.25.camel@jmg.helius.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

All,

I am having trouble getting a Soundblaster live 24-bit to work.  I have
built 1.0.11rc3 (drivers, libs, utils) on a 2.4.19 kernel running on a
very old Caldera system with limited updates (the card worked fine on my
debian/testing machine).  (I don't have a choice on the system.)  I had
to modify the /etc/rc.d/init.d/alsasound and /usr/sbin/alsaconf scripts
to work with very old versions of bash and grep. When I enter aplay as
follows:

aplay  -Dplug:cards.pcm.default -f S32_LE -c2 -r44100 /dev/urandom

It responds with the following but I never get any sound.

Playing raw data '/dev/urandom' : Signed 32 bit Little Endian, Rate
44100 Hz, Stereo

I can also give it short wav files and it never returns.
In /proc/interrupts, I get no or very limited interrupt action.
In /proc/asound/timers I get the following:

G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
  Client application 29540 : stopped
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
P0-2-1: PCM capture 0-2-1 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE
P0-3-1: PCM capture 0-3-1 : SLAVE

What would cause the process to freeze and be stopped like is indicated
above?  What can I do?  Any suggestions?

Jim Gleason




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
