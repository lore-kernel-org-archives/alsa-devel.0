From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/8] ASoC: OMAP: RX-51 Machine driver and
 AIC34b_dummy driver
Date: Fri, 9 Oct 2009 09:37:20 +0300
Message-ID: <20091009063720.GC6616__4423.98591335422$1255070567$gmane$org@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
	<20091008131116.GB29176@rakim.wolfsonmicro.main>
	<20091009084400.34df690a.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091009084400.34df690a.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2009 at 07:44:00AM +0200, Jarkko Nikula wrote:
> On Thu, 8 Oct 2009 14:11:16 +0100
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > What is an "AIC34b_dummy (block B)"?  You probably want to split it out
> > into a separate patch.
> > 
> I think this is the reason why Eduardo mentioned my name in the commit
> log :-)

Yeah, I mentioned Jarkko because he was the person who initially wrote those drivers :-).

But I can split then if you prefer. No problem.

> 
> Yep, dummy driver is for block B of AIC34 which is basically dual AIC33
> in a same package.

Yes. This is correct.

> 
> > > + * TODO:
> > > + * - Get rid of this driver, at least when ASoC v2 is merged and when
> > > + *   we can support multiple codec instances in tlv320aic3x.c driver.
> > > + *   This driver is hacked only for Nokia RX51 HW.
> > 
> > Could you please explain what the issue here is?  A description of the
> > hardware would go a long way here.
> > 
> Eduardo, please correct me if I remember wrong  but block B of AIC34 is
> not used as an codec as such but more like an amplifier and analogic
> mixer with digital parts unused. So with this dummy driver the HW
> features were easier to support than to develop multiple intance
> support for codec drivers.


Yes. This is also correct. It is more like an amplifier / mixer.
I think that's why you named it dummy :-).

But I think I should add this info as a comment inside the code.


> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin
