From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: prevent compilers from optimising
 pll calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 16:06:08 +0100
Message-ID: <20110427150607.GD31952@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0911A103865
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 17:06:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Barry Song <bs14@csr.com>, Barry Song <21cnbao@gmail.com>, Zhiwu Song <zhiwu.song@csr.com>, Binghua Duan <binghua.duan@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 27, 2011 at 07:59:39AM -0700, Stephen Warren wrote:

> Aren't there compiler flags that tell gcc it isn't operating in a hosted(?)
> environment, and hence not to emit calls to these functions? If so, I
> imagine they should be added to the kernel's core (or ARM arch ) makefiles.

IIRC there's some intrinsics (usually for operations like divisions)
which GCC expects to be provided even in a free standing environment.
