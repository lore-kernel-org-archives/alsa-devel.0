From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: ALSA release 1.0.1
Date: Thu, 8 Jan 2004 18:13:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040108231300.GA526@zewt.org>
References: <Pine.LNX.4.58.0401081520520.13704@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (postfix@h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA27463
	for <alsa-devel@alsa-project.org>; Fri, 9 Jan 2004 00:13:03 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401081520520.13704@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2004 at 07:15:10PM +0100, Jaroslav Kysela wrote:
> * alsa-driver

  CC [M]  /home/glenn/alsa-driver-1.0.1/usb/usbaudio.o
/home/glenn/alsa-driver-1.0.1/usb/usbaudio.c: In function `snd_usb_find_csi=
nt_desc':
/home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:1755: error: `USB_DT_CS_INTERF=
ACE' undeclared (first use in this function)
/home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:1755: error: (Each undeclared =
identifier is reported only once
/home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:1755: error: for each function=
 it appears in.)
/home/glenn/alsa-driver-1.0.1/usb/usbaudio.c: In function `parse_audio_endp=
oints':
/home/glenn/alsa-driver-1.0.1/usb/usbaudio.c:2341: error: `USB_DT_CS_ENDPOI=
NT' undeclared (first use in this function)
make[2]: *** [/home/glenn/alsa-driver-1.0.1/usb/usbaudio.o] Error 1
make[1]: *** [/home/glenn/alsa-driver-1.0.1/usb] Error 2

linux-2.6.0/sound/usb/usbaudio.h defines these, but
alsa-driver-1.0.1/alsa-kernel/usb/usbaudio.h does not.  Copying in the
kernel header fixed it.

> * alsa-lib

I'm still getting "snd_pcm_plug_hw_params: Assertion `err >=3D 0' failed."
=66rom a couple weeks ago.  I can work around it, but I'm also working
around other things (such as that CS46xx chip that doesn't work with
4k or 8k buffers), and the result starts to be brittle ...

--=20
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
