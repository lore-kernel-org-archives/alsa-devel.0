From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Mon, 15 Apr 2002 13:35:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020415123532.10CC94CA8@xun0.sr.bham.ac.uk>
References: <20020415121617.6442736F9@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020415121617.6442736F9@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com, Patrick Shirkey <kotau@firstlinux.net>, Paul Davis <pbd@op.net>, James@superbug.demon.co.uk
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 15 Apr 2002 13:16, Patrick Shirkey wrote:
> --- Paul Davis <pbd@op.net> wrote:
> >>>framework for ALSA worked out, which is even more of a problem. Its
> >>>still unclear at this point whether the ALSA framework will be:
> >>>
> >>>     
> >>> application<->alsa-lib<->alsa-driver<->low-level-ALSA-USB-class-driver
> >>>
> >>>OR
> >>>
> >>>      application<->alsa-lib<->low-level-non-ALSA-USB-class-driver
> >>>
> >>>the first one is easier to write, the second one is more flexible.
>
> I think a good example of how ALSA should work with USB devices is the
> gphoto approach. From what I know of their framework it is along the same
> lines as the first option.

I think a more exact description of the gphoto approach is:
application<->gphoto-lib<->usb-lib<->low-level-generic-USB driver.

Only the low-level kernel USB drivers and the usbdevfs filesystem are in 
kernel space, beyond that the hardware driving is done via the user-space 
libusb. I'm not sure whether this would have low-enough latency for audio 
use, after all, digital cameras aren't timing-critical for the sort of things 
that gphoto aims to do.


-- 
+------------------------+-------------------------------+---------+
| James Tappin           | School of Physics & Astronomy |  O__    |
| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
+--------------------------------------------------------+---------+
