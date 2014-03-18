From: Rongjun Ying <Rongjun.Ying@csr.com>
Subject: Re: [PATCH 2/2] ASoC: sirf-audio-codec: Add missing
	Makefile entry
Date: Tue, 18 Mar 2014 02:04:34 +0000
Message-ID: <86130EF012BDF348AA0D464A4F449478012AE59413@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1394785572-28315-1-git-send-email-lars@metafoo.de>
 <1394785572-28315-2-git-send-email-lars@metafoo.de>
 <20140317170049.GV11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
 [85.115.60.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 84C48261A84
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 03:04:47 +0100 (CET)
In-Reply-To: <20140317170049.GV11706@sirena.org.uk>
Content-Language: zh-CN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Barry Song <baohua@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, March 18, 2014 1:01 AM
> To: Lars-Peter Clausen
> Cc: Liam Girdwood; Rongjun Ying; Barry Song; alsa-devel@alsa-
> project.org
> Subject: Re: [PATCH 2/2] ASoC: sirf-audio-codec: Add missing Makefile
> entry
> 
> On Fri, Mar 14, 2014 at 09:26:12AM +0100, Lars-Peter Clausen wrote:
> > Without this the driver can't be built.
> 
> Yeah.  On the other hand until the issue with sharing the registers
> between the CODEC and DAI drivers is resolved I'm not sure this is a
> bad thing.  There were some patches for that which I didn't look at yet
> though.

Hi Mark:
I have implemented audio hub driver to sharing the register for internal codec, port and I2S controller.
Please help to review it.

Thanks.
RongJun Ying 


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
