From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Fri, 13 Dec 2002 10:53:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m27keexn25.fsf@vador.mandrakesoft.com>
References: <3DF8A109.2030206@gmx.de> <s5hel8nuvee.wl@alsa2.suse.de>
	<3DF8B8FA.3040009@gmx.de> <s5h3cp3uorz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cp3uorz.wl@alsa2.suse.de> (Takashi Iwai's message of "Thu,
 12 Dec 2002 18:32:00 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > Mandrake Control Center recognices the card as follows (partly in
> > german, sorry, but perhaps that's no problem in ERL/NUE ;-) ):
> > 
> > Hersteller: Fortemedia, Inc
> > Bus: PCI
> > Bus: 1319:801:1319:1319
> > Standort auf den Bus: 0:b:0
> > Beschreibung: Xwave QS3000A [FM801]
> > Modul: snd-fm801
> > Medienklasse: MULTIMEDIA_AUDIO

this information came frome harddrake which uses libldetect (which is
also used by lspcidrake).

bus is vendor_id:card_id:subvendor_id:subcard_id
bus position (Standort auf den Bus) is pci_bus:pci_device:pci_function
Beschreibung is of course description of the device and Hersteller is
vendor
module is of course kernel module

the driver association is made by libldetect from
/usr/share/ldetect-lst/pcitable :

tv@vador ~ $ fgrep fm801 /usr/share/ldetect-lst/pcitable
0x1319  0x0801  "snd-fm801"  "Fortemedia, Inc|Xwave QS3000A [FM801]"
0x1319  0x1000  "snd-fm801"  "Fortemedia, Inc|FM801 PCI Audio"

> > I had no alsa installed while running hardware detection.

alsa drivers're included in mandrake kernel

> you can check this also via lspci command.

lspcidrake -v will give him the module too

> in the output of lspci in your last mail, the i/o ports and irq are
> missing.  please check again?

in order to have the full information, i would like Friedrich to send
us the following information (what i call the classic bug sound
tester) :

"lspcidrake -v | fgrep AUDIO" will tell you which driver your card use
by default

"grep snd-slot /etc/modules.conf" will tell you what driver it
currently uses

"/sbin/lsmod" will enable you to check if its module (driver) is
loaded or not

"/sbin/chkconfig --list sound" and "/sbin/chkconfig --list alsa" will
tell you if sound and alsa services're configured to be run on
initlevel 3

"aumix -q" will tell you if the sound volume is muted or not

"/sbin/fuser -v /dev/dsp" will tell which program uses the sound card.


this will tell us at which stage the problem happen



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
