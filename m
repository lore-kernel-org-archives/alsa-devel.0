From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Two sound cards, only sound out of one
Date: Sun, 24 Aug 2003 12:13:53 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

Using version 0.9.6 of alsa-*.

I have two ENS1371 based cards plugged into the one machine:

    root@sound:~# cat /proc/asound/cards
    0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                         Ensoniq AudioPCI ENS1371 at 0xa400, irq 10
    1 [AudioPCI_1     ]: ENS1371 - Ensoniq AudioPCI
                         Ensoniq AudioPCI ENS1371 at 0x9400, irq 5

I have also set up a /etc/asound.conf file containing aliases for the
cards named "card0" and "card1".

I have also run alsamixergui with "-c 0" and "-c 1" parameters to set up
output volumes on the two cards (and the controls on the two alsamixergui
instances behave independantly).

However, when I playback a sound file using:

    aplay -D card0 a.wav
    aplay -D card1 a.wav

Only card0 produces sound. I have also tried physically swapping the cards
but only card0 produces sound. I have also tried the -v option to aplay to
confirm that the output is going to device 0 and device 1.

The relevant sections of /etc/modules.conf looks like this:

    alias char-major-116 snd
    alias snd-card-0 snd-ens1371
    alias snd-card-1 snd-ens1371
    alias char-major-14 soundcore
    alias sound-slot-0 snd-card-0
    alias sound-slot-1 snd-card-1
    alias sound-service-0-0 snd-mixer-oss
    alias sound-service-0-1 snd-seq-oss
    alias sound-service-0-3 snd-pcm-oss
    alias sound-service-0-8 snd-seq-oss
    alias sound-service-0-12 snd-pcm-oss
    alias sound-service-1-0 snd-mixer-oss
    alias sound-service-1-1 snd-seq-oss
    alias sound-service-1-3 snd-pcm-oss
    alias sound-service-1-8 snd-seq-oss
    alias sound-service-1-12 snd-pcm-oss
    options snd major=116 cards_limit=2 device_gid=29 device_mode=0660
    options snd-ens1371 index=0,1

Anybody got any idea why this is not working?

Thanks,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"If you don't know what you need Windows NT for, you don't need it."
  - Bill Gates


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
