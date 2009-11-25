From: "Narnakaje, Snehaprabha" <nsnehaprabha-l0cyMroinI0@public.gmane.org>
Subject: RE: Handling two audio codec in the same kernel
Date: Wed, 25 Nov 2009 12:06:44 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012B5950DF@dlee02.ent.ti.com>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922213604.GB4736@sirena.org.uk> <4ABA3C52.6010509@ridgerun.com>
	<20090923154916.GA4257@sirena.org.uk> <4ABA4855.9080201@ridgerun.com>
	<20090923163914.GB31134@opensource.wolfsonmicro.com>
	<4B0C0BD5.9050407@ridgerun.com>
	<20091125112100.GA18883@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20091125112100.GA18883-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org]
> Sent: Wednesday, November 25, 2009 6:21 AM
> To: Miguel Aguilar
> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org;
> clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org; santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org;
> diego.dompe-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; Narnakaje,
> Snehaprabha; todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org
> Subject: Re: Handling two audio codec in the same kernel
> 
> On Tue, Nov 24, 2009 at 10:37:41AM -0600, Miguel Aguilar wrote:
> 
> > * How is the proper way to register both codecs in the same kernel?
> 
> At the minute you can't really.  However, if the CODEC for the voice
> interface is mostly empty (which I seem to recall was the case?) then
> you can skip registering the CODEC and only register the DAI.

Yes, voice codec does not call the snd_soc_register_codec handler. But it does call the snd_soc_register_dai handler. However we have the snd_soc_codec_device structure defined for the voice codec. This structure initializes the probe, remove, suspend and resume handlers for the voice codec. This probe function initializes the voice codec peripheral, powers it on and adds the controls for amixer. However the probe function does not get invoked since we have configured AIC3101 codec as the default codec for .codec_dev in the snd_soc_device structure. Some how, we have to invoke the voice codec probe function. Not sure, if the evm_init() in sound/soc/davinci/davinci-evm.c is the right place to call soc_codec_dev_cq93vc.probe(). It seems to work if I call the .probe() in evm_init().

It looks like we also need to comment out snd_soc_init_card() in the voice codec probe function, since the card would already have registered by the AIC3101 codec.

Question related to amixer - should we be seeing controls for both the codecs? How do we change the gain settings specific to a codec?

Thanks
Sneha

> 
> > * If I have registered in the same kernel, How I can choose the codec
> > that will be used in the alsamixer menu?
> 
> The application layer will do this based on which DAI it chooses to play
> audio down - each will appear separately to them, as you're doing below.
> 
> > The DMA logic works fine as you see in the examples above. However, only
> > the AIC works recording/playback, the voice codec doesn't work. If I
> > switch the default codec to Voice Codec it works.
> 
> Initially I'd suggest testing with hw rather than plughw to make sure
> the test is isolated to the drivers.
