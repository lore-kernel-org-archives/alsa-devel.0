From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Thu, 12 Dec 2002 17:27:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF8B8FA.3040009@gmx.de>
References: <3DF8A109.2030206@gmx.de> <s5hel8nuvee.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
many thanks for your quick reply! Here's some more info:

Mandrake Control Center recognices the card as follows (partly in 
german, sorry, but perhaps that's no problem in ERL/NUE ;-) ):

Hersteller: Fortemedia, Inc
Bus: PCI
Bus: 1319:801:1319:1319
Standort auf den Bus: 0:b:0
Beschreibung: Xwave QS3000A [FM801]
Modul: snd-fm801
Medienklasse: MULTIMEDIA_AUDIO

I had no alsa installed while running hardware detection.

The soundcard is working correctly under win98 without the need to 
change any hardware or bios settings.
win98 reports:
fm801 pci audio, IRQ 10, I/O: EC00-EC7F
plus
fm801 pci audio, IRQ 11
and 'no conflicts'. I.e. win98 shows up the same IRQs used as lspci, 
that should be correct, then. But lspci doesn't name any memory regions 
used by this card. Do you have any idea what I could try? (I'll test 
some other bios settings, mounting the card in another slot when I find 
some spare time).

TIA
fe


Takashi Iwai schrieb:

>At Thu, 12 Dec 2002 15:45:29 +0100,
>Friedrich Ewaldt wrote:
>  
>
>>Hi!
>>
>>I've got a fm801 based sound card which locks my computer completely 
>>some seconds after loading the alsa driver module. I compiled drivers 
>>with debug=detect -- please see my mail(s) from 12/09/2002 on alsa 
>>userlist for more info. What else could I do? Meanwhile I found several 
>>reports describing the same problem.
>>Therefore my question(s): Should it be possible to run a fm801 soundcard 
>>using the 0.9.0rc6 or cvs driver? Anyone who has installed such a card 
>>successfully? Any ideas what I'm doing wrong? (I have installed some 
>>other soundcards using alsa09 without problems.)
>>    
>>
>
>it looks like a hardware problem rather than the driver itself.
>as lspci shows, your fm801 card has no resources at all.
>something wrong with either the soundcard itself or the combination
>with the mobo...
>can you verify the hardware?
>
>
>Takashi
>  
>



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
