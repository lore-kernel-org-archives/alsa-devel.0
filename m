From: Dan Hollis <goemon@anime.net>
Subject: Re: alsa 0.9.0rc2 trident incompatible with 2.4.19
 pcigame?
Date: Mon, 16 Sep 2002 03:33:35 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209160326380.32537-100000@sasami.anime.net>
References: <s5h8z22tety.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z22tety.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Sep 2002, Takashi Iwai wrote:
> Dan Hollis wrote:
> > I can't seem to use kernel 2.4.19 pcigame (trident) joystick driver with 
> > 0.9.0rc2.
> it was already integrated on alsa, as the oss trident driver on 2.5
> integrated, too.
> doesn't the joystick work without pcigame module?

no, it doesn't work.

% cat /proc/asound/cards 
0 [card0          ]: TRID4DWAVENX - Trident TRID4DWAVENX
                     Trident TRID4DWAVENX PCI Audio at 0x1400, irq 11
% cat /proc/asound/devices 
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
% cat /proc/asound/oss/devices
  2: [0- 2]: raw midi
  0: [0- 0]: mixer
  3: [0- 3]: digital audio
 12: [0-12]: digital audio
% cat /proc/asound/card0/trident 
Trident 4DWave PCI NX

Spurious IRQs    : 0
Spurious IRQ dlta: 0
IEC958 Mixer Out : off
Rear Speakers    : off

Virtual Memory
Memory Maximum : 16777216
Memory Used    : 0
Memory Free    : 16777216

Wavetable Synth
Memory Maximum : 8388608
Memory Used    : 0
Memory Free    : 8388608

0.9.0rc2 trident driver on kernel 2.4.19 doesn't seem to have any joystick 
support at all.

you're quite sure 0.9.0rc2 trident driver on 2.4.19 has builtin joystick
support? i can't seem to find it in the source.

ymfpci, cmipci, etc. do seem to have it in the source.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
