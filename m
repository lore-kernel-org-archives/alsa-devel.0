From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: Reenable use from userspace
Date: Mon, 02 Nov 2015 10:47:31 +0000
Message-ID: <1446461251.2623.26.camel@loki>
References: <1445830900-1752-1-git-send-email-broonie@kernel.org>
 <20151031025448.GA28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3652607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 11:47:35 +0100 (CET)
In-Reply-To: <20151031025448.GA28319@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Mendong Lin <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-10-31 at 11:54 +0900, Mark Brown wrote:
> On Mon, Oct 26, 2015 at 12:41:40PM +0900, Mark Brown wrote:
> > We had inserted a #error into the topology UAPI code to ensure that the
> > ABI was not adopted by userspace while final review and testing was
> > ongoing.  Since we are now comfortable that the ABI is suitable for
> > production remove the #error, future changes will include provision for
> > backwards compatibility.
> 
> > Are we OK with this?  Looking for some acks and reviews...
> 
> I saw a reply from Vinod but nobody else here.

Mengdong are we good here ?

Liam
