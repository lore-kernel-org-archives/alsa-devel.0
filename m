From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 0/6] core: add compress data API to ALSA
 kernel
Date: Tue, 06 Dec 2011 13:37:45 +0530
Message-ID: <1323158865.1641.12.camel@vkoul-udesk3>
References: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
	<1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<CABb+yY0sh6oMD+C7Uj9D4A_XyL4XBL3YQOxyjkx0v5D7JMiNVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ADF41038B1
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 09:09:22 +0100 (CET)
In-Reply-To: <CABb+yY0sh6oMD+C7Uj9D4A_XyL4XBL3YQOxyjkx0v5D7JMiNVQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-06 at 12:57 +0530, Jassi Brar wrote:
> Hi Vinod,
Hello Jassi,
> 
> On Mon, Dec 5, 2011 at 1:09 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> > As agreed during the ASoC workshop in May 2011, this set of patches are a
> > proposal from Intel to add a new compressed data interface to ALSA. This
> > proposal builds on the existing Intel solution and the experience gathered over
> > two years with Meego and Android solutions. This proposal is no longer
> > Intel-specific and was generalized with the addition of a basic core;
> > codec-related definitions are based on the vendor-neutral OpenMAX AL standard.
> >
> Is the layer, below this API, available somewhere to see the whole picture ?
The parameters for codecs which need to be passed to DSP were derived
from the OpenMAX AL standard. So if you want to implement this standard
or some other parameter format, the assumption is that the neutrality of
API should ensure that it works for all.

-- 
~Vinod
