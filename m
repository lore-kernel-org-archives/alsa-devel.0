From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: The ALSA Situation
Date: Fri, 12 Nov 2004 09:24:46 +0100
Message-ID: <20041112082446.GA16172@rhlx01.fht-esslingen.de>
References: <20041112040611.8390B1D2669@sc8-sf-uberspam1.sourceforge.net>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20041112040611.8390B1D2669@sc8-sf-uberspam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Manuel Jander <manuel.jander@usm.cl>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Nov 11, 2004 at 08:05:24PM -0800, alsa-devel-request@lists.sourceforge.net wrote:
> Subject: Re: [Alsa-devel] The ALSA Situation
> From: Manuel Jander <manuel.jander@usm.cl>
> Reply-To: mjander@users.sourceforge.net
> To: Takashi Iwai <tiwai@suse.de>,
>    alsa-devel <alsa-devel@lists.sourceforge.net>
> Date: Thu, 11 Nov 2004 19:52:47 -0300

> 2) * Multichannel card:
>   - Use one channel for softmixing (reserved for ever for that purpose,
> at highest audio quality). Just the same as for the single channel card.
>   - Use a "Resource Manager" that assigns hardware channels as are
> available, and choose the softmixing engine coupled to the reserved
> channel when we get out of hardware channels.

Don't we have a problem here??

If we have 4 hardware-mixed channels and 7 sound streams, then we end
up with:
a) H/W (1/4)
b) H/W (1/4)
c) H/W (1/4)
d) H/W (1/4): S/W (1/4), S/W (1/4), S/W (1/4), S/W (1/4)
== (!!)
d) H/W (1/4) * S/W (1/4) each == S/W (1/16) each !!

which clearly has a different volume (1/16 of total output) than each
of the H/W-mix-only channels (1/4).

Hmm, OTOH there's a 150% likelihood that the card can adjust hardware
channel volume individually, so just adjust channel d) to have 4 times
the volume of each other H/W channel and you end up with equal volume.

OK, so that should be a non-issue after all (but we need to remember to
adjust H/W channel volume each time the number of S/W channels changes!),

Andreas Mohr


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
