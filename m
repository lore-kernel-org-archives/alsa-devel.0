From: mark@undertone.org
Subject: Re: btw
Date: Thu, 17 Oct 2002 10:20:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021017152042.GB14352@undertone.org>
References: <20021014191214.GB6704@undertone.org> <20021014192959.GA6792@undertone.org> <20021014193407.GA6821@undertone.org> <s5h8z106km8.wl@alsa2.suse.de> <20021015175750.GA8918@undertone.org> <s5hof9u666f.wl@alsa2.suse.de> <20021016194055.GA11982@undertone.org> <s5h8z0x5v3r.wl@alsa2.suse.de> <20021017134235.GA14241@undertone.org> <s5h4rbl5e9y.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4rbl5e9y.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 17, 2002 at 04:30:17PM +0200, Takashi Iwai wrote:
> this is shown exactly in /proc/asound/card*/stream*.

Neat.

> iirc, the 48000Hz 16bit 2ch is the only supported format on extigy.
> (there should be more, but they are likely not parsed correctly - see
>  below.)

How very interesting. I immediately start wondering how it processes
3d audiofiles or surround sound off a dvd... left as an exersise for
myself I guess...

> but anyway it's strange that the format above is not accepted by
> plughw.  please check
> 
> - whether the files mathing with native format are ok.

Yup, seems to work fine. To continue the testing from before with this
newfound pcm stream, the only newfound knowledge is that the "pcm"
control seems to work.

> - whether the file above with OSS emulation works (which converts
>   inside the kernel).

Uh hmm doesn't seem to. I'm truthfully not sure of the most ideal way
to test this. I tested it by loading up the alsa-oss modules and using
some oss programs that reference /dev/dsp (which in this case gets
symlinked to sound/dsp).

> i'm not sure what's going on there, but the lsusb output once you sent
> me contains much more supported formats.
> and i experienced that the similar phenomenon happened on other
> usb-audio devices - not the whole descriptors are parsed.
> the behavior might be changed if you reboot.  sigh...

I've rebooted many times. Seems consistant.

> i guess it's likely a bug of usb controller modules.

Suck. With the work being put in, I wonder how hard it would be to
cajole Creative Labs to ship you a free extigy to play with, heh. Who
knows, they might even end up supplying some specs.

-mark


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
