From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA release 1.0.1
Date: Fri, 9 Jan 2004 09:37:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401090937230.1879@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0401081520520.13704@pnote.perex-int.cz>
 <20040108231300.GA526@zewt.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA04399
	for <alsa-devel@alsa-project.org>; Fri, 9 Jan 2004 09:44:28 +0100
In-Reply-To: <20040108231300.GA526@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <g_sf@zewt.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Jan 2004, Glenn Maynard wrote:

> On Thu, Jan 08, 2004 at 07:15:10PM +0100, Jaroslav Kysela wrote:
> > * alsa-driver
> 
>   CC [M]  /home/glenn/alsa-driver-1.0.1/usb/usbaudio.o
> /home/glenn/alsa-driver-1.0.1/usb/usbaudio.c: In function `snd_usb_find_csint_desc':
> /home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:1755: error: `USB_DT_CS_INTERFACE' undeclared (first use in this function)
> /home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:1755: error: (Each undeclared identifier is reported only once
> /home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:1755: error: for each function it appears in.)
> /home/glenn/alsa-driver-1.0.1/usb/usbaudio.c: In function `parse_audio_endpoints':
> /home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:2341: error: `USB_DT_CS_ENDPOINT' undeclared (first use in this function)
> make[2]: *** [/home/glenn/alsa-driver-1.0.1/usb/usbaudio.o] Error 1
> make[1]: *** [/home/glenn/alsa-driver-1.0.1/usb] Error 2
> 
> linux-2.6.0/sound/usb/usbaudio.h defines these, but
> alsa-driver-1.0.1/alsa-kernel/usb/usbaudio.h does not.  Copying in the
> kernel header fixed it.

Use 2.6.0-rc or 2.6.1 kernels.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
