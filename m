From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: ALSA 1.0.5
Date: Tue, 1 Jun 2004 22:07:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406012207.29689.plcl@telefonica.net>
References: <E1BUbHW-0005Wg-PQ@sc8-sf-list2.sourceforge.net> <200405311258.53199.plcl@telefonica.net> <s5h1xkzsmaz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xkzsmaz.wl@alsa2.suse.de>
Content-Disposition: inline
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

On Tuesday 01 June 2004 10:40, Takashi Iwai wrote:
> Pedro Lopez-Cabanillas wrote:
> > Anybody using the same hardware should avoid the 1.0.5 driver, IMO.
> > Relevant sources are ac97_codec.c and ac97_patch.c. The problem was
> > related to a mutex deadlock.
>
> yep, sorry, my bad.
> the bug hits AC97 codecs with paging, ALC655/658/850 and STAC9758.

There is some risk on the bleeding edge of any software, but I'm very happy to 
say that it's worth to try the 1.0.5a driver if you own that hardware. Once 
the annoying bug has been sorted out, the integrated sound of my Gigabyte 
works very well now. Thanks!

Regards,
Pedro



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
