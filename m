From: Benno Senoner <sbenno@gardena.net>
Subject: Re: Max # of cards, pcm devices, midi devices Was: max SNDRV_CARDS
 bug ? questions ....
Date: Wed, 03 Dec 2003 23:25:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCE62EF.6060702@gardena.net>
References: <3FCE32B5.1030208@gardena.net> <s5had6acaqf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had6acaqf.wl@alsa2.suse.de>
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

Takashi Iwai wrote:

>At Wed, 03 Dec 2003 20:00:05 +0100,
>Benno Senoner wrote:
>  
>
>>Hi,
>>(I'm using alsa-driver-1.0.0rc1)
>>
>>I have a question about the SNDRV_CARDS.
>>normally it is defined as 8
>>./alsa-kernel/core/memalloc.c: #define SNDRV_CARDS     8
>>
>>Does that mean we can have a maximum of 8 soundcards
>>in the PC or is this simply how many instances a certain module supports ?
>>(eg I could have 8 emu10k instances, 8 sb16 instances etc ?).
>>    
>>
>
>no, totally 8 instances.  not the number of modules.
>
Please elaborate here:  
does that mean that if I have 3 soundcards (eg. 3 emu10k1 cards) and 6 
snd-serialmidi devices
( = total of 9 "cards"), that this configuration does not work ?


>>Plus I noticed something in
>>
>>./alsa-kernel/core/memalloc.c: static int enable[8] = {[0 ... 
>>(SNDRV_CARDS-1)] = 1};
>>
>>shouldn't that be:
>>static int enable[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 1};     ?
>>    
>>
>
>yes, but not a bug as long as SNDRV_CARDS = 8 :)
>
Then I see no reason not to fix it, or at least place a big FIXME in the 
sources near the
SNDDRV_CARDS definition.
Otherwise when these SNDRV_CARDS limits will be lifted someday developes
will need to fix these nasty fixed array size assumption.

>
>  
>
>>is this a bug ? what happens if we set SNDRV_CARDS to a value > 8 ?
>>    
>>
>
>more than 8 cards are not supported in the current assignment of
>devices.  the minor devices will be out of range.
>
I did look at /dev/snd:

devicename, maj, min

/dev/snd/midiC0D0  116, 8  
/dev/snd/midiC0D1  116, 9
....
/dev/snd/midiC0D7  116,15

/dev/snd/pcmC0D0p 116, 16
/dev/snd/pcmC0D1c  116,25
/dev/snd/pcmC0D1p  116,17
/dev/snd/pcmC0D2c  116,26
...

Is that the minor devices conflict you are refering to ?
I assume the midi serial devices allocate a /dev/snd/midiC0Dx device 
thus only 8 midi ports
per card are allowed.
After midiC0D7 (116,15) comes  pcmC0D0p (116, 16) so there would be no 
room for
midiC0D8, right ?

The question is now: is it possible to change the device major,minor 
number layout to allow
for more /dev/snd/midiCxDy devices (and simultaneously increasing 
SNDRV_CARDS) ?

Is it simply a matter of changing the snddevices script or does 
alsa-driver/alsa-lib make assumptions
about the devicenode numbers thus rendering such modifications useless ?

About the minor number:
I understand it is limited to 1 byte thus has a 0-255 range.
I did look at the snddevices script and it seems that every card uses 32 
minor numbers thus
32 * 8 cards = 256 = full range used.
Even if the script only creates the device nodes for the first 4 cards 
(thus minor numbers 0-127) I assume
you can redefine MAX_CARDS in the script and create the device nodes for 
all 8 cards.

in
./alsa-kernel/include/minors.h  I see:

#define SNDRV_MINOR_DEVICES             32
#define SNDRV_MINOR_CARD(minor)         ((minor) >> 5)
#define SNDRV_MINOR_RAWMIDI             8       /* 8 - 15 */
#define SNDRV_MINOR_RAWMIDIS            8
#define SNDRV_MINOR_PCM_PLAYBACK        16      /* 16 - 23 */
#define SNDRV_MINOR_PCM_CAPTURE         24      /* 24 - 31 */
#define SNDRV_MINOR_PCMS                8


So basically as far as I understand those macros would need to to be 
changed too.
I see PCM_PLAYBACK and PCM_CAPTURE each taking up 8 device nodes each.
Perhaps I could reduce that to 4 thus making room for 2*4=8 more RAWMIDI 
devices ?
(but these are per card so I guess that is the wrong way to go, read below)

The question how many multiple PCM_PLAYBACK devices are usually needed ?
Of course this depends from the card. For example for my CMI8738MC6 card
in /proc/asound I see:  pcm0c, pcm0p, pcm1p, pcm2c, pcm2p
thus 3 devices each for playback and capture.
What happens in the case of the hammerfall where you can have up to 24 
playback channels ?
Is that seen as a single capture/playback device  ? Or cards like the 
delta 1010 ?
Ok the good old Steve Harris just did a cat /proc/asound/ on his 
Hammerfall box for me:
 id, oss_mixer, pcm0c, pcm0p, rme9652
So it means it uses only one pcm device.

But the big doubt is: since Takashi said each snd_serialmidi device 
allocates one of the available
SNDRV_CARDS slots it basically means that we use only one midiCxDy per card.
If I use the module options line Takashi gave me

options snd-serialmidi enable=1,1,1,1 
sdev=/dev/ttyS2,/dev/ttyS3,/dev/ttyS4,/dev/ttyS5

and I do aconnect I get something like
72:0  Serial Midi Device 1  (or was the name Raw Midi ? does not matter 
for explanation purposes).
80:0  Serial Midi Device 2
88:0  ....

So I assume of each "card" only /dev/snd/midiCxD0 is used.
Correct me if I'm wrong.
To make it short, do you think I have a chance to succeed increase 
SNDRV_CARDS to 12-16
(and change the snddevices script and the SNDRV_ macros) ?
Must each card use a power of two (currently 32) of minor device nodes ?
If that is true then the only alternative would be SNDRV_CARDS = 16 but 
that would leave only
16 minor numbers for card which is too little to make fit a few pcm 
devices, rawmidi and the other stuff neded.
Perhaps the ideal tradeoff would be SNDRV_CARDS=12 but that would 
require a per card
minor device number that is not a  power of two.
Ok some macros would become a bit slower eg (assuming 20 minor ids per card)

#define SNDRV_MINOR_CARD(minor)         ((minor)  / 20)

But this is not the end of the world.

Let me know please. I'll share my experiences (problems, failures, 
success etc) here on the mailing list.

thanks,
Benno
http://www.linuxsampler.org




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
