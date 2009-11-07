From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
 tracking nonsense
Date: Sat, 7 Nov 2009 20:12:33 +0000
Message-ID: <20091107201233.GC31789@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CE1A103891
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 21:12:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 11:51:16AM -0700, Grant Likely wrote:
> On Sat, Nov 7, 2009 at 5:51 AM, Jon Smirl <jonsmirl@gmail.com> wrote:

> current period.  My understanding of ALSA is that the application is
> supposed to make sure there is enough silence in the buffer to handle
> the lag between notification that the last period with valid data has
> been played out and the stop trigger.

This is certainly the most robust approach for applications.  For a
large proportion of hardware it won't matter too much since they're able
to shut down the audio very quickly but that can't be entirely relied
upon, especially at higher rates on slower machines.

> occur.  That says to me that the real problem is an unbounded latency
> caused by another part of the kernel (the tty console in this case).

That's certainly not going to help anything here - if a delay is
introduced in telling the hardware to shut down the DMA then that
increases the chance for the DMA controller to start pushing valid audio
data from the buffer to the audio interface.

> > A much cleaner solution would be for ALSA to provide a field that
> > indicates the last valid address in the ring buffer system. Then in
> > the driver's buffer complete callback I could get that value and
> > reprogram the DMA engine not to run off the end of valid data. As each
> > buffer completes I would reread the value and update the DMA stop
> > address. You also need the last valid address field when DMA is first
> > started.

> ... assuming that audio needs to stop exactly at the end of valid
> data.  But if the last few periods are silence, then this assumption
> isn't true.

Indeed, it makes the whole thing much more reliable.

Providing a final valid data point to the driver would possibly even
make things worse since if it were used then you'd have the equivalent
race where the application has initialised some data but not yet managed
to update the driver to tell it it's being handed over; if the driver
just carries on running through the data there's a reasonable chance
nobody will notice that case.
