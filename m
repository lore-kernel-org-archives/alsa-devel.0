From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Edirol UA-20 PCM support
Date: Mon, 24 Feb 2003 14:12:24 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302241409180.20472-100000@studcom.urz.uni-halle.de>
References: <20030224122354.GA9568@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030224122354.GA9568@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Frank Barknecht wrote:
> Clemens Ladisch wrote:
> I compiled alsa-driver from CVS with you patch applied. alsalib still
> is rc7. I can get audio-out with alsaplayer or ecasound in Advanced
> Mode using the plugin layer.

So PCM works.  :-)

> OSS-emulation doesn't work.

OSS doesn't support 24-bit sample formats.

> I cannot use or see the midi devices (anymore).

Are there any messages in /var/log/messages? Is interface #3 in use by the
snd-usb-audio driver (see /proc/bus/usb/devices)?


Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
