From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: VIA8233/8235 testers wanted
Date: Fri, 10 Jan 2003 09:17:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301100917.28794.styx@gentoo.org>
References: <s5h7kde8dfm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kde8dfm.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 09 January 2003 18:01, Takashi Iwai wrote:
> Hi,
>
> if someone has VIA8233, VIA8233A, VIA8233C or VIA8235 chipset, could
> you help the testing of the new driver?
> the new driver code is found at
>
> 	http://www.alsa-project.org/~iwai/via82xx.c
> [...]

I'm getting an unresolved symbol: snd_pcm_substream_sgbuf, and a recursive 
grep in the alsa-driver sources show only one match in, you guessed it, 
snd-via82xx.c.

Regards,


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
