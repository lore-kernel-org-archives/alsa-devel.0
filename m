From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for
	sram-support-less platforms
Date: Mon, 1 Oct 2012 16:54:11 +0100
Message-ID: <20121001155410.GR4360@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
	<1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
	<20120922153313.GN4495@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA92A1D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA92A1D-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Girdwood,  Liam" <lrg-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 27, 2012 at 06:57:49AM +0000, Hebbar, Gururaja wrote:

> I have no knowledge about multi-platform builds yet.

> Currently this driver is shared between OMAP & DaVinci and both of them 
> doesn't exist in single image build.

...due to issues like having compile time things selecting between the
platforms.  In other words what these ifdefs would do is move us further
away from that goal rather than towards it as we should be doing.

> There was a effort done for this SRAM Consolidation [1] but it didn't progress.
> Hence I took this approach as a time-being/workaround. This was we can get 
> affected platforms (like AM335x) get going/working.

Looks like it just needs more people pushing it...
