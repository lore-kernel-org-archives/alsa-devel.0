From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: aplay not playing MPEG
Date: Tue, 22 Jul 2003 19:21:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307221919270.5535-100000@pnote.perex-int.cz>
References: <20030721144218.92.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030721144218.92.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Jul 2003, Eliot Blennerhassett wrote:

> Can aplay/alsa send raw MPEG data to a card?
> 
>   aplay -Dhw:0  -v -t raw --channels=2 --format=MPEG --rate=44100 ~/audio/44khz
>   Playing raw data '/home/eliot/audio/44khz' : MPEG, Rate 44100 Hz, Stereo
>   aplay: set_params:805: Sample format non available
> 
> This command works fine if I specify S16_LE, S23, FLOAT, S24, but not MPEG.
> Any suggestions as to whe - do I have a hope of making it work?
> (My card supports all the above including MPEG in exactly the same way as far as
> ALSA driver is concerned)
> 
> I have stepped through the code, and got lost in the bit twiddling of masks and
> formats.  One thing I notice is that only the linear formats are mentioned in
> many of the functions in pcm_misc.c eg  snd_pcm_format_width()

The handshake between driver and applications is not defined for MPEG and 
other compressed formats.

Can you describe the MPEG stream which your hardware expects? It will help 
us to design the APIs.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
