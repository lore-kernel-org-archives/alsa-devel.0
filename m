From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Tue, 20 Apr 2004 19:39:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404201939.54966.bero@arklinux.org>
References: <200404171945.35824.bero@arklinux.org> <s5hd663q6fs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd663q6fs.wl@alsa2.suse.de>
Content-Disposition: inline
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

On Tuesday 20 April 2004 12:39, Takashi Iwai wrote:
> > Hi,
> > On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID 1019:0f22),
> > snd_ali5451 loads and can adjust mixer settings (except for PCM volume,
> > but I think that's a limitation of the hardware), but doesn't make any
> > noise - apparently PCM is always muted (volume fixed at 0?).
>
> there is no PCM volume on CM9739.  it has only PCM mute switch.
> you can mute on/off via 'M' key of alsamixer.

I knew that -- it doesn't make any sound even if it's unmuted though.
Nothing useful in dmesg output either.

LLaP
bero


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
