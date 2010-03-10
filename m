From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/20] ASoC: S3C: I2Sv2:
	Segregate	hw_params callback
Date: Wed, 10 Mar 2010 18:46:31 +0000
Message-ID: <20100310184629.GK6850@sirena.org.uk>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<20100310141417.GZ24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 191DE24359
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 19:46:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100310141417.GZ24422@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 02:14:17PM +0000, Mark Brown wrote:
> On Wed, Mar 10, 2010 at 04:48:58PM +0900, Jassi Brar wrote:
> > Towards having build for multiple SoCs segregate hw_params callback
> > for s3c2412 and s3c64xx.
> > Since, all new SoCs have s3c64xx like register map, we keep that as
> > default implementation if no SoC specific callback is already defined.

> > Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

> This is OK but appears to depend on one or more of the other patches
> that didn't get applied yet.

Actually it does apply - patch 3 hadn't actually made it into the queue
I was applying and that was the dependency.  I've now got them both
applied, though they were missing from the pull I sent to Takashi
earlier so I've not pushed them up to kernel.org yet.
