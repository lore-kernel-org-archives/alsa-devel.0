From: Benno Senoner <sbenno@gardena.net>
Subject: max SNDRV_CARDS bug ? questions ....
Date: Wed, 03 Dec 2003 20:00:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCE32B5.1030208@gardena.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
(I'm using alsa-driver-1.0.0rc1)

I have a question about the SNDRV_CARDS.
normally it is defined as 8
./alsa-kernel/core/memalloc.c: #define SNDRV_CARDS     8

Does that mean we can have a maximum of 8 soundcards
in the PC or is this simply how many instances a certain module supports ?
(eg I could have 8 emu10k instances, 8 sb16 instances etc ?).

Plus I noticed something in

./alsa-kernel/core/memalloc.c: static int enable[8] = {[0 ... 
(SNDRV_CARDS-1)] = 1};

shouldn't that be:
static int enable[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 1};     ?

is this a bug ? what happens if we set SNDRV_CARDS to a value > 8 ?
Does this generate memory corruption problems ?
(keep in mind I'm not familiar with the alsa-driver sourcebase so I 
could say nonsense)

I grepped the entire source for 'enable[' and the only place where I 
found enable[8] was
in the ./alsa-kernel/core/memalloc.c file.

Basically the reason why I wrote this mail is to ask if I can use more than
8 snd-serialmidi devices.
Takashi gave me the module parameter options to make it work.
(BTWthanks Takashi ! :-) )

options snd-serialmidi enable=1,1,1,1 
sdev=/dev/ttyS2,/dev/ttyS3,/dev/ttyS4,/dev/ttyS5

but if you look at the drivers/serialmidi.c source
....
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;static char 
*sdev[SNDRV_CARDS] = {"/dev/ttyS0", [1 ... (SNDRV_CARDS - 1)] = ""};
....

all arrays are of size SNDRV_CARDS this means that I can have max 8 
serial devices.
So what do you suggest to allow for example 12 serial midi devices ? 
(via multi port serial card).
just set SNDRV_CARDS to 12 and fix the enable[8] statement in memalloc.c ?

Or should I simply use a local SNDRV_CARDS in serialmidi.c ? (eg #define 
SERIAL_SNDRV_CARDS 12) ?
(the latter is a hack so I guess it's more convenient to change the 
global SNDRV_CARDS define  right ?).

I posted this mail just to be sure that alsa does not becomes unstable 
or something breaks because of the
define change.

Let me know please.

thanks,
Benno
http://www.linuxsampler.org






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
