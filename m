From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support as
	well as I2C
Date: Thu, 28 Aug 2008 11:14:35 +0100
Message-ID: <20080828101434.GB11132@sirena.org.uk>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-4-git-send-email-cooloney@kernel.org>
	<20080827110143.GB10834@sirena.org.uk>
	<386072610808272046u270c1302g1102bf1f0bd9b6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CB8C245D8
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 12:14:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <386072610808272046u270c1302g1102bf1f0bd9b6ee@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 28, 2008 at 11:46:24AM +0800, Bryan Wu wrote:
> On Wed, Aug 27, 2008 at 7:01 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > ...as for the SSM2602 it'd be good if it were possible to build a kernel
> > which supports both I2C and SPI.  If you like I could do this for you -
> > there's likely to be merge issues due to the update to the new I2C API
> > anyway?

> Oh, do you mean SSM2602 or WM8731? I also noticed the i2c API updates
> patch from Jean and I'd like to use the new one

Sorry, that could've been clearer - I meant wm8731.  Obviously if you
want to update that too then that would be great but I figured it'd make
life easier for you if I were to ensure that one gets merged OK.  Which
way do you prefer?
