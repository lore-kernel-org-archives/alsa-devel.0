From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Fri, 8 Nov 2002 00:11:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021107231105.GC560@tuba.home>
References: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.44.0211071037490.16062-100000@cmn37.stanford.edu>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA30407
	for <alsa-devel@alsa-project.org>; Fri, 8 Nov 2002 00:11:15 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071037490.16062-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, clemens@ladisch.de, alsa-devel@alsa-project.org, ws@seh.de
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2002 at 10:54:10AM -0800, Fernando Pablo Lopez-Lezcano wrote:
> 
> ./rawmidi -v -i hw:1,0
> Using: 
> Input: device hw:1,0
> Output: NONE
> ALSA lib rawmidi.c:247:(snd_rawmidi_open_conf) symbol _snd_rawmidi_hw_open 
> is not defined inside (null)
> snd_rawmidi_open hw:1,0 failed: -6
> Closing
> 


I can't reproduce this, but I was playing a little bit with rawmidi...
So, if my client is aconnected (aconnect 80:0 73:0) I can't catch an error
with rawmidi trying all four possibilties.

If I disconnect (aconnect -x) my keyboard I can produce an error. This
situation is the only possibility to see an error message and it must be
"rawmidi -v -i hw:2,0,0". The other three rawmidi options are running fine and
didn't show an error. Yes, "rawmidi -v -i hw:2,0" does his job without
problems and the message is also different to Fernando's output.

tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i hw:2,0,0
Using: 
Input: device hw:2,0,0
Output: NONE
ALSA lib rawmidi_hw.c:247:(snd_rawmidi_hw_open) SNDRV_RAWMIDI_IOCTL_INFO
failed: No such device
snd_rawmidi_open hw:2,0,0 failed: -19
Closing


martin


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
