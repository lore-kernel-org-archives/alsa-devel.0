From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd-usb-audio in ALSA 0.9.0rc5
Date: Thu, 14 Nov 2002 10:09:51 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211141000490.503-100000@pnote.perex-int.cz>
References: <200211140034.17681.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211140034.17681.plcl@telefonica.net>
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

> On Wednesday 13 November 2002 09:50, Clemens Ladisch wrote:
> > Pedro Lopez-Cabanillas wrote:
> > > IMHO, mapping the card MIDI ports to subdevices may be OK, but only for
> > > ALSA native rawmidi. After all, you can access some MIDI port with
> > > "hw:x,y,z" instead of "hw:x,y", but for OSS emulation a better approach
> > > is needed. For major 14, why not to bind minors sequentially for each
> > > MIDI port on the system? I mean: first port minor=2, second port
> > > minor=18, ... thru -and up- minor=242 (/dev/midi15) if needed, regardless
> > > of ALSA card numbers?
> >
> > This would break if cards are loaded dynamically, i.e. the port number
> > would depend on the order the drivers are loaded.
> 
> Yes, but not only the driver's loading order matters. With USB devices, the 
> hub's port number and the plug-in order may cause troubles, too. With my UM-2 
> and Midisport2x2, both using snd-usb-audio driver, i was used to cat 
> /proc/asound/seq/clients from time to time, to know which client number had 
> each device, until i've found a solution that is the same as for driver 
> loading order. This is a snippet from my modules.conf file:
> 
> alias char-major-14 soundcore
> alias char-major-116 snd
> alias snd-card-0 snd-ens1371
> alias snd-card-1 snd-usb-audio
> alias snd-card-2 snd-usb-audio
> options snd cards_limit=3
> options snd-ens1371 index=0
> options snd-usb-audio index=1,2 vid=0x0763,0x0582 pid=0x1110,0x0005
> 
> Since i've found this trick, i don't need to wonder about client numbers as 
> they always are the same. It doesn' matter which device i plug-in first, 
> neither which USB hub port it uses. 72 is always Midisport and 80 is UM-2.
> 
> I don't know if there is a better way, and i'm not sure if it shall work  for 
> OSS rawmidi also. 
> 
> > Well, for obvous reasons (i.e. laziness), the current answer for this is
> > "don't use OSS".  ;-)
> 
> You're kidding :-) You made a great, tireless work with ALSA usb driver, and 
> ALSA as a whole is going to be beautiful too... but there are a lot of worthy   
> OSS legacy apps (i.e. PD), and many cheap and ubiquitous USB MIDI multiport 
> devices now. IMHO, ALSA should be able to give support to both worlds.
> 
> Of course, this issue must be addressed very carefully, having some previous 
> discussions with final consensus.
> 
> About device minor numbers, i've heard that Linux 2.6 shall break actual  
> limitations, with a 32 bits kdev_t, divided up to 12 bits for major and 20 
> bits for minor. Anybody can confirm this?

It's not implemented in 2.5:

typedef struct {
        unsigned short value;
} kdev_t;

#define KDEV_MINOR_BITS         8
#define KDEV_MAJOR_BITS         8


Have you tried to create the virtual MIDI device (snd-virmidi.o) ? You can
connect any sequencer port to a rawmidi device (and first two rawmidi
devices are mapped to the OSS space as well). Note that virmidi module can
occupy up to 8 card slots (in your environment with 3 real soundcards, you
can create up to 10 oss rawmidi devices).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
