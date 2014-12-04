From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH 1/5] ASoC: dwc: Allocate resources with
	devm_ioremap_resource
Date: Thu, 04 Dec 2014 09:05:01 +0000
Message-ID: <548023BD.8020804@arm.com>
References: <547F3C96.9070509@arm.com> <20141203182659.GG7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id A4726260560
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 10:05:01 +0100 (CET)
In-Reply-To: <20141203182659.GG7712@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/03/14 18:26, Mark Brown wrote:
> On Wed, Dec 03, 2014 at 04:38:46PM +0000, Andrew Jackson wrote:
>> Prepare for the introduction of device-tree support by re-ordering some
>> of the allocations and using devm_iomap_resource to simplify IO mapping.
> 
> Applied, thanks.
> 

Lars-Peter Clausen had some comments on this patch so I was intending to resubmit it.  Would you prefer that I submit a patch to my original?

  Andrew
