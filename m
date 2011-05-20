From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] davinci: da850evm: enable mcasp ping-pong bufs and
	evq's
Date: Fri, 20 May 2011 12:38:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CFDD2CE@dbde02.ent.ti.com>
References: <cover.1305723716.git.bengardiner@nanometrics.ca>
	<f02f2bda26f87fff2bb9e958baa12672cae7e362.1305723716.git.bengardiner@nanometrics.ca>
	<20110519211406.GE18849@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20110519211406.GE18849-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Subhasish Ghosh <subhasish-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Girdwood, Liam" <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, May 20, 2011 at 02:44:06, Mark Brown wrote:
> On Wed, May 18, 2011 at 09:27:46AM -0400, Ben Gardiner wrote:
> > The davinci-mcasp driver will copy the platform data specified sram sizes and
> > eventq's.
> > 
> > Set the event queues and sram sizes for da850. 8K SRAM buffers are selected
> > because it is the minimum that resulted in the same period size when testing
> > 48KHz S16_LE stereo. Event queues 0 and 1 are assigned to match those 
> > specified by Troy Kisky in his introduction of ping-pong buffers for dm644x.
> > 
> > Signed-off-by: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
> 
> Davinci folks, are you OK with this?

No, please don't merge this just yet. As Ben mentioned in his cover
letter, the default SRAM pool on DA850 is not suitable for Audio
transfers. This patch depends on SRAM not being available for audio
usage in spite of the platform asking for it. This is liable to break.

The SRAM allocation on DaVinci and OMAP is under a bit of flux and
once that is sorted out, this patch should be safe to merge. So,
this probably needs to wait for 2.6.41.

Thanks,
Sekhar
