From: Frank Barknecht <fbar@footils.org>
Subject: Re: [PATCH] Edirol UA-20 PCM support
Date: Mon, 24 Feb 2003 13:23:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030224122354.GA9568@fliwatut.scifi>
References: <Pine.HPX.4.33n.0302241114310.11386-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0302241114310.11386-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo Clemens,
Clemens Ladisch hat gesagt: // Clemens Ladisch wrote:

> This adds support for the UA-20's PCM interfaces in "Advanced Driver"
> mode. The device has all standard descriptors, so the normal descriptor
> parsing code can be used, but the interface class is set to "vendor
> specific".

I compiled alsa-driver from CVS with you patch applied. alsalib still
is rc7. I can get audio-out with alsaplayer or ecasound in Advanced
Mode using the plugin layer. OSS-emulation doesn't work. Starting Pd
hangs my laptop.  Its last messages are that Pd cannot open
/dev/snd/pcmX. I don't know, if the crash is caused by ALSA or by a
conflict between A. Mortons lowlatency patch and ext3 on 2.4.20. Pd
crashes the box even if lowlatency is disabled.

I cannot use or see the midi devices (anymore). 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
