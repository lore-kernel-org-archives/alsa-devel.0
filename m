From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [RFC PATCH 2/2] ASoC: select sysclk clock from
 mlck clock provider in wm8994 driver
Date: Fri, 15 Dec 2017 11:46:06 +0000
Message-ID: <20171215114606.6wxw2m5rykmb7ak2@localhost.localdomain>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 22A5F267B4F
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:46:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171214173624.GM9788@sirena.org.uk>
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
Cc: benjamin.gaignard@st.com, alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 05:36:24PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 05:53:58PM +0100, Olivier Moysan wrote:
> > When defined in device tree, MCLK1 and MCLK2 are used
> > as sysclk for aif1 and aif2 interfaces respectively.
> 
> That's not a valid assumption as far as I remember?  The AIFs can use
> either MCLK depending on the system configuration I think.
> 

Indeed yes the code added here is literally just above the code
that selects that, it should be fairly simple to update the patch
to take this into account.

Thanks,
Charles
