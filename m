From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/5] Remove ASoC-level I/O functions from cq93vc
Date: Mon, 2 Sep 2013 10:55:34 +0200
Message-ID: <20130902085534.GP20329@zurbaran>
References: <20130831130741.GG18608@sirena.org.uk>
	<20130901144847.GM20329@zurbaran>
	<20130901150853.GG3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130901150853.GG3084-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sun, Sep 01, 2013 at 04:08:53PM +0100, Mark Brown wrote:
> On Sun, Sep 01, 2013 at 04:48:47PM +0200, Samuel Ortiz wrote:
> 
> > As I'd prefer to carry the MFD ones (Including the twl6040 one) through
> > mfd-next, I can build a branch for you to pull from. Would that be fine
> > with you ?
> 
> That's fine by me, I just want the patches in ASoC - obviously the
> branch couldn't be rebased though.
I put a topic/for-asoc branch upstream for you to pull from:

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-next.git topic/for-asoc

for you to fetch changes up to c6f39257c952bc7da974bf93255936ff2ece2c34:

  mfd: twl6040: Use regmap for register cache (2013-09-02 10:30:14
+0200)

----------------------------------------------------------------
Mark Brown (3):
      mfd: davinci_voicecodec: Remove unused read and write functions
      mfd: davinci_voicecodec: Provide a regmap for register I/O
      mfd: twl6040: Use regmap for register cache

 drivers/mfd/davinci_voicecodec.c       |   23 +++++++++++++----------
 drivers/mfd/twl6040.c                  |   43 ++++++++++++++++++++++++++++++-------------
 include/linux/mfd/davinci_voicecodec.h |    3 +++
 include/linux/mfd/twl6040.h            |    1 -
 4 files changed, 46 insertions(+), 24 deletions(-)

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
