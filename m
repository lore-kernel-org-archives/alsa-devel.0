From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding
	style level
Date: Tue, 5 Dec 2017 14:01:17 +0100
Message-ID: <81e17b9c-e878-1fe9-bb6f-b074d5766232@maciej.szmigiero.name>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B0B7266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 14:01:23 +0100 (CET)
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, caleb@crome.org, timur@tabi.org, broonie@kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On 04.12.2017 21:46, Nicolin Chen wrote:
> ==Background==
> The fsl_ssi driver was designed for PPC originally and then it has
> been updated to support different modes for i.MX Series, including
> SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
> contributors for different use cases in different coding styles.
> 
> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
> 
> So I am going to clean up the driver in both coding style level and
> program flow level.
> 
> ==Introduction==
> This series of patches is the first set to clean up fsl_ssi driver
> in the coding style level. Any patch here is not supposed to change
> the program flow.
> 
> ==Verification==
> Theoretically, it only needs code review, build and sanity tests. I
> have done build and sanity tests on an i.MX 6 platform by building
> using imx_v6_v7_defconfig and testing with I2S slave/master mode.

Thanks for your cleanup work.

Due to my current workload I will be able to go through this and test
the AC'97 mode on a UDOO board only in about a week.

Maciej
