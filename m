From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: The ALSA Situation
Date: Fri, 12 Nov 2004 10:33:58 -0300
Message-ID: <1100266438.2082.6.camel@localhost>
References: <20041112040611.8390B1D2669@sc8-sf-uberspam1.sourceforge.net>
	 <20041112082446.GA16172@rhlx01.fht-esslingen.de>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041112082446.GA16172@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@lisas.de, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, 2004-11-12 at 09:24 +0100, Andreas Mohr wrote:
> Hi,
> > 2) * Multichannel card:
> >   - Use one channel for softmixing (reserved for ever for that purpose,
> > at highest audio quality). Just the same as for the single channel card.
> >   - Use a "Resource Manager" that assigns hardware channels as are
> > available, and choose the softmixing engine coupled to the reserved
> > channel when we get out of hardware channels.
> 
> Don't we have a problem here??
> 
> If we have 4 hardware-mixed channels and 7 sound streams, then we end
> up with:
> a) H/W (1/4)
> b) H/W (1/4)
> c) H/W (1/4)
> d) H/W (1/4): S/W (1/4), S/W (1/4), S/W (1/4), S/W (1/4)
> == (!!)
> d) H/W (1/4) * S/W (1/4) each == S/W (1/16) each !!
> 
> which clearly has a different volume (1/16 of total output) than each
> of the H/W-mix-only channels (1/4).
> 
> Hmm, OTOH there's a 150% likelihood that the card can adjust hardware
> channel volume individually, so just adjust channel d) to have 4 times
> the volume of each other H/W channel and you end up with equal volume.
> 
> OK, so that should be a non-issue after all (but we need to remember to
> adjust H/W channel volume each time the number of S/W channels changes!),

OK, there maybe some details, but that it absolutely irrelevant, because
it *can* be solved. The really import thing here IMHO is to solve the
concurrent access to the soundcard in a most useful manner, which is an
issue that is *not* solved yet.

-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
