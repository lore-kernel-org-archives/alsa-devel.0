From: Markus Gaugusch <markus@gaugusch.at>
Subject: Re: SonyPI module and via82xx sound driver
Date: Mon, 5 Jan 2004 15:42:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0401051541060.3789@tweety.gaugusch.at>
References: <Pine.LNX.4.53.0312282043360.31435@tweety.gaugusch.at>
 <s5hisjq31js.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisjq31js.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Jan 5, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 28 Dec 2003 20:47:07 +0100 (CET),
> Markus Gaugusch wrote:
> >
> > Hi,
> > The sonypi module uses IO Address 0x1080 - 0x1084B, which is in the range
> > of the via82xx sound driver (0x1000 - 0x10ff). Is it possible to exclude
> > the address range of the sonypi module in the via82xx driver? I'm pretty
> > sure that it isn't really used by ALSA :)
>
> check lspci -v whether the via chip requires really this whole
> region.  in the via82xx driver, we reserve the area with 256 bytes,
> assuming that it's constant.  if lspci shows a different value,
> i.e. 128 bytes, the driver should reserve the region according to the
> pci resource.
Unfortunately, the region is shown with 256 bytes:
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
Audio Controller (rev 50)
        Subsystem: Sony Corporation: Unknown device 80f6
        Flags: medium devsel, IRQ 5
        I/O ports at 1000 [size=256]
        I/O ports at 1c54 [size=4]
        I/O ports at 1c50 [size=4]

Is there any hope for a fix?

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus(at)gaugusch.at  X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
