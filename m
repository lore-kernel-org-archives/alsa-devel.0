From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3] ASoC: DaVinci: Added two clocking possibilities to
	McBSP (I2S)
Date: Tue, 6 Jul 2010 17:00:24 +0530
Message-ID: <38684.6524001614$1278458052@news.gmane.org>
References: <1278405544-3852-1-git-send-email-lamiaposta71@gmail.com>	
	<1278405544-3852-2-git-send-email-lamiaposta71@gmail.com>
	<1278409559.3103.136.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1278409559.3103.136.camel@odin>
Content-Language: en-us
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: 'Liam Girdwood' <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, 'Raffaele Recalcati' <lamiaposta71-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, 'Takashi Iwai' <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, 'Jaroslav Kysela' <perex-/Fr2/VpizcU@public.gmane.org>, 'Raffaele Recalcati' <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Jul 06, 2010 at 15:15:59, Liam Girdwood wrote:
> On Tue, 2010-07-06 at 10:39 +0200, Raffaele Recalcati wrote:
> > From: Raffaele Recalcati <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
> > 
> >     Added two clocking options for dm365 McBSP peripheral when used
> >     with I2S timings, that are SND_SOC_DAIFMT_CBS_CFS (the cpu generates
> >     clock and frame sync) and SND_SOC_DAIFMT_CBS_CFM (the cpu gets clock
> >     from external pin and generates frame sync).
> >     A slave clock management can be important when the external codec needs
> >     the system clock and the bit clock synchronized (tested with uda1345).
> >     This patch has been developed against the:
> >         http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> >     git tree and has been tested on bmx board (similar to dm365 evm, but using
> >     uda1345 as external audio codec).
> > 
> > Signed-off-by: Raffaele Recalcati <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
> > Signed-off-by: Davide Bonfanti <davide.bonfanti-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
> 
> All
> 
> Acked-by: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> 
> But lets get some feedback from the DaVinci folks on this too.
> 

Acked-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>

Regards,
Sudhakar
