From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd-usb-audio in ALSA 0.9.0rc5
Date: Fri, 15 Nov 2002 15:37:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211151537140.1607-100000@pnote.perex-int.cz>
References: <200211142223.21891.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211142223.21891.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Nov 2002, Pedro Lopez-Cabanillas wrote:

> On Thursday 14 November 2002 10:09, Jaroslav Kysela wrote:
> > Have you tried to create the virtual MIDI device (snd-virmidi.o) ? You can
> > connect any sequencer port to a rawmidi device (and first two rawmidi
> > devices are mapped to the OSS space as well). Note that virmidi module can
> > occupy up to 8 card slots (in your environment with 3 real soundcards, you
> > can create up to 10 oss rawmidi devices).
> 
> Thanks! this works! I didn't gave virmidi a shot before, but i think it is a 
> good solution: i can use both ports of my USB devices with OSS programs.
> 
> BTW, there is a little problem with this module:
> 
> # modinfo snd-virmidi
> filename:    /lib/modules/2.4.19/kernel/sound/drivers/snd-virmidi.o
> description: "Dummy soundcard for virtual rawmidi devices"
> author:      "Takashi Iwai <tiwai@suse.de>"
> parm:        index int array (min = 1, max = 8), description "Index value for 
> virmidi soundcard."
> parm:        id string array (min = 1, max = 8), description "ID string for 
> virmidi soundcard."
> parm:        enable int array (min = 1, max = 8), description "Enable this 
> soundcard."
> parm:        midi_devs_Rb3ae63d0 int array (min = 1, max = 8), description 
> "MIDI devices # (1-8)"
> 
> "midi_devs" is a versioned symbol belonging to OSS Free 
> (linux/drivers/sound/dev_table.h) and i compiled my kernel with versioned 
> symbols and OSS/free drivers.
> Some releases ago this param was named "snd_midi_devs". Can we rename it 
> again? Are there more clashes?

I think that '#undef midi_devs' should be sufficient. Added to CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
