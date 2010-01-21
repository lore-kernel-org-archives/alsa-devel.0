From: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] Add Voice Codec support for DaVinci platforms
Date: Thu, 21 Jan 2010 13:36:34 -0600
Message-ID: <1264102595.3207.180.camel@linux-1lbu>
References: <4B58904E.4030108@ridgerun.com>
	<1264099975.3207.176.camel@linux-1lbu>
	(sfid-20100121_185231_613114_5A2091DA)
	<66B80913-5079-4E5D-8D89-0CE78D02A14C@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <66B80913-5079-4E5D-8D89-0CE78D02A14C-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Santiago Nunez <santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, clarkbecker <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-01-21 at 19:25 +0000, Mark Brown wrote:
> On 21 Jan 2010, at 18:52, Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > On Thu, 2010-01-21 at 11:35 -0600, Miguel Aguilar wrote:
> >> Hi,
> >>
> >> The following patch series adds support for the Voice Codec in the  
> >> Davinci
> >> platform and in this particular case for the DM365 EVM.
> >>
> >> The DM365 EVM has two codecs the AIC3x and the Voice Codec, however  
> >> at this
> >> point is not possible to have both enabled simultaneously since the  
> >> soc-core
> >> doesn't support that, so a patch for enable both simultaneously  
> >> will be sent
> >> when this support is available in the soc-core.
> >
> > I thought, perhaps incorrectly, that soc-core already has the  
> > ability to
> > support multiple codecs.  When I worked on ALSA soc support for  
> > DM6467,
> > one of the McASP was connected to AIC3x and the other is SPDIF output.
> > Both interface can work at the same time.  I just assumed that if we
> > have two  McASP (or other audio controllers) connected to two codecs.
> > They would both just work under ALSA soc.  Please let me know if I'm
> > mistaken.
> 
> It can only cope with one CODEC with registers. That S/PDIF interface  
> has no registers so could be made to work.

I just pull up the code and looked at it again.  You are right.  Sorry
about the noise.

Steve
