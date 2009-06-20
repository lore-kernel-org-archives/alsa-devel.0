From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Sat, 20 Jun 2009 19:15:39 -0400
Message-ID: <200906201915.39935.rgetz@blackfin.uclinux.org>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	<8bd0f97a0906190405k33503d8ekd74ec9ddbb2fde12@mail.gmail.com>
	<A40FAF28-889C-4322-A114-098EEA56FCE6@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id BF8652456B
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 01:12:31 +0200 (CEST)
In-Reply-To: <A40FAF28-889C-4322-A114-098EEA56FCE6@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri 19 Jun 2009 07:13, Mark Brown pondered:
> On 19 Jun 2009, at 12:05, Mike Frysinger <vapier.adi@gmail.com> wrote:
> > On Fri, Jun 19, 2009 at 06:47, Mark Brown wrote:
> >> This will require that the arch code for any systems with the ad1938
> >> do the setup of the device.
> >
> > so should sound/soc/blackfin/bf5xx-ad1938.c even exist in the first  
> > place ?
> 
> Yes. It is needed in order to specify how things are hooked up on a  
> given board.

This has always kind of bugged me about ASOC - (or maybe it is just my 
ignorance about the architecture decisions that were made).

Any reason why platform/board specific things are in sound/soc/arch rather 
than arch/xxxx/boards - like the majority of drivers?

?
