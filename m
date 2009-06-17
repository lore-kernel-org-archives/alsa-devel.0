From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Progress in adding ams-delta support to ASoC?
Date: Wed, 17 Jun 2009 16:12:38 +0200
Message-ID: <4A38F9D6.5000803__24503.851918462$1245247988$gmane$org@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl>	<20090608094028.415e6ec3.jhnikula@gmail.com>	<4A2E7921.7090200@tis.icnet.pl>	<4A364B1A.5040905@tis.icnet.pl>
	<20090615181633.4570426f.jhnikula@gmail.com>
	<4A37AFA9.4080403@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A37AFA9.4080403@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Janusz Krzysztofik wrote:
> After all, it is more and more likely that the problem is not dma, but 
> mcbsp just not shifting any data for some mysterious reason.

I finally did what I should have already done before: learned about 
dynamic debugging, turned it on and probably got the answer from 
omap_msbsp_dump_reg(): all mcbsp1 register read operations returned 
0xffff. So it looks like I simply get no acccess to mcbsp1 at all. Now I 
wonder if I can close this thread with a conclusion that mcbsp1 on 
opam15xx is simply not yet supported by the mainline kernel that I have 
based my work on.

Thanks,
Janusz
