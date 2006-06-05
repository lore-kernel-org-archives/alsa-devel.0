From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [PATCH] Add support for Yamaha AICA sound on SEGA
	Dreamcast
Date: Mon, 05 Jun 2006 10:59:32 +0100
Message-ID: <1149501573.6144.21.camel__20203.1543282375$1149509156$gmane$org@localhost.localdomain>
References: <1149201071.9032.13.camel@localhost.localdomain>
	<20060605095318.GA30339@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk
	[81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 1DBAC151
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jun 2006 11:59:55 +0200 (MEST)
In-Reply-To: <20060605095318.GA30339@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-05 at 12:53 +0300, Paul Mundt wrote:

> > +static void spu_init(void)
> 
> This can probably be inlined..
> 
> > +/* aica_chn_start - write to spu to start playback */
> > +static void aica_chn_start(void)
> > +{
> > +	spu_write_wait();
> > +	writel(AICA_CMD_KICK | AICA_CMD_START,
> > +	       (uint32_t *) AICA_CONTROL_POINT);
> > +}
> > +
> > +/* aica_chn_halt - write to spu to halt playback */
> > +static void aica_chn_halt(void)
> > +{
> > +	spu_write_wait();
> > +	writel(AICA_CMD_KICK | AICA_CMD_STOP,
> > +	       (uint32_t *) AICA_CONTROL_POINT);
> > +}
> > +
> These too.
> 

No point in inlining these as they all wait on a FIFO to clear - ie the
benefit of inling will be tiny. I notice a stray inline still lurking
from the code that can go...
