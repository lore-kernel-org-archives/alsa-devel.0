From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Two sound cards, only sound out of one
Date: Sun, 24 Aug 2003 10:51:20 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030824095120.49055.qmail@web40613.mail.yahoo.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
wrote:
> Using version 0.9.6 of alsa-*.
> 
> I have two ENS1371 based cards plugged into the one
> machine:
> 
>     root@sound:~# cat /proc/asound/cards
>     0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
>                          Ensoniq AudioPCI ENS1371 at
> 0xa400, irq 10
>     1 [AudioPCI_1     ]: ENS1371 - Ensoniq AudioPCI
>                          Ensoniq AudioPCI ENS1371 at
> 0x9400, irq 5
 
> However, when I playback a sound file using:
> 
>     aplay -D card0 a.wav
>     aplay -D card1 a.wav
> 
> Only card0 produces sound.
> 
> Anybody got any idea why this is not working?

Just checking the obvious: have you plugged any
speakers into the second sound card?

Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
