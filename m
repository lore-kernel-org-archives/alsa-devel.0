From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Two sound cards, only sound out of one
Date: Mon, 25 Aug 2003 13:13:37 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308251310590.14875-100000@studcom.urz.uni-halle.de>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Erik de Castro Lopo wrote:
> I have two ENS1371 based cards plugged into the one machine:
>
>     root@sound:~# cat /proc/asound/cards
>     0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
>                          Ensoniq AudioPCI ENS1371 at 0xa400, irq 10
>     1 [AudioPCI_1     ]: ENS1371 - Ensoniq AudioPCI
>                          Ensoniq AudioPCI ENS1371 at 0x9400, irq 5
>
> I have also set up a /etc/asound.conf file containing aliases for the
> cards named "card0" and "card1".
>
> I have also run alsamixergui with "-c 0" and "-c 1" parameters to set up
> output volumes on the two cards (and the controls on the two alsamixergui
> instances behave independantly).
>
> However, when I playback a sound file using:
>
>     aplay -D card0 a.wav
>     aplay -D card1 a.wav
>
> Only card0 produces sound. I have also tried physically swapping the cards
> but only card0 produces sound. I have also tried the -v option to aplay to
> confirm that the output is going to device 0 and device 1.

The same happens with "hw:1" instead of "card1"?

Is the output of "lspci -x" the same for both cards (except port and
irq settings)?

Are the mixer controls really exactly the same (run "alsactl store"
and look into /etc/asound.state)?


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
