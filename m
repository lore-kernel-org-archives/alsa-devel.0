From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Thu, 18 Jun 2009 09:07:12 +0300
Message-ID: <20090618090712.8f8ecd53.jhnikula__13130.2414964468$1245305214$gmane$org@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200906030924.14230.jkrzyszt@tis.icnet.pl>
	<20090605165531.7d0c4522.jhnikula@gmail.com>
	<200906060028.01600.jkrzyszt@tis.icnet.pl>
	<20090608094028.415e6ec3.jhnikula@gmail.com>
	<4A2E7921.7090200@tis.icnet.pl> <4A364B1A.5040905@tis.icnet.pl>
	<20090615181633.4570426f.jhnikula@gmail.com>
	<4A37AFA9.4080403@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A37AFA9.4080403@tis.icnet.pl>
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
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Jun 2009 16:43:53 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> >>> - original patch ported to the last l-o commit supporting
> >>> omap-alsa:
> >>>   - playback: works as before,
> >>>   - capture: both </dev/dsp and arecord give null output,
> >>>     but DMA interrupts still work.
> I can confirm that the old driver can set up mcbsp in a way that
> keeps it shifting the contents of its input register, loaded with a
> pattern using omap_mcbsp_pollwrite() as Peter suggested, even if I
> break dma by commenting out all omap_start_dma() invocations. I have
> verified this by detecting averaged voltage level changes on the
> codec input pin with a simple multimeter (I still have not get access
> to a scope back).
> 
Heh, clever and adequate enough test at the moment until we'll get bit
running over the interface :-)

> Using the new driver, I am not able to detect similiar voltage
> changes, whatever I do to get the mcbsp sending data to the codec
> over its serial output. I have modified omap-mcbsp code with a hacked
> in probe hook that initializes mcbsp at boot time exactly as the old
> driver does it - no results.
> 
Hmm, recall, did you try hacking the ASoC driver at the same commit
d8376cc482b241701f7606c81ad578b90853e175 where older driver still
exists and works? There has been ASoC OMAP fixes and changes since
then but nothing which can explain why it doesn't work now for 1510.

There we would know that clock framework, register access etc. works for
McBSP on 1510.


-- 
Jarkko
