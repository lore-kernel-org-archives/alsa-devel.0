From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Is a complete Alsa restart possibly without rebooting?
Date: Wed, 6 Aug 2003 10:04:00 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGIEKKCOAB.mknecht@controlnet.com>
References: <20030806163009.GA5872@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030806163009.GA5872@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Debian has an init-script that accepts a "force-[stop|restart]"
> option. What this does is: It first kills all programs that use ALSA
> with:
>
> procs_using_sound="$(echo $({ find /dev -print0 | xargs -0 stat
> -Lc '%t:%n' | grep -E '^(e|74):' \
> | cut -d: -f2-; } | while read REPLY; do fuser "$REPLY" || true;
> done | cut -f2- -d:))"
> kill $procs_using_sound
> sleep 2
> kill -9 $procs_using_sound
>
> and then rmmods like this:
>
> rmmod -r $(lsmod | grep ^snd | awk '{print $1}')
>
> Hope that helps... I could send you the file (or you could get it from
> debian.org), but basically that's it.
>
> ciao
> --
>  Frank Barknecht                               _ ______footils.org__

Frank,
   I don't think you need to send the file. So far this is sort of what I'm
doing by hand, but it isn't working. I can stop audio apps, then stop Alsa,
remove everything from memory (I think), and then restart Alsa. Alsa starts
up cleanly with no error messages, but sound does not return.

   As I said earlier, I think there *may* be two other things going on here:

1) The sound card hardware is a strange state after the driver does bad
things to it.
2) alsasound start does not apparently reset the hardware completely.

   I can understand #2 conceptually since the reboot sets up PCI addressing
and does other things to the card. If the driver was to mangle the PCI
address of the card (I'm not suggesting it does, but just for instance) then
I suppose the driver could not and should not try to fix that. My problem
right now is I cannot see what's getting messed up, so I do not know how to
reset it.

   Luckily it's a pretty fast machine and a reboot is only about 45 seconds,
but it's frustrating to have to shut down email and other things to do it.

Thanks much,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
