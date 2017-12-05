From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding
	style level
Date: Tue, 5 Dec 2017 11:33:00 -0800
Message-ID: <20171205193258.GA11039@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <81e17b9c-e878-1fe9-bb6f-b074d5766232@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 76AB326698E
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 20:33:00 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id o2so851541pgc.8
 for <alsa-devel@alsa-project.org>; Tue, 05 Dec 2017 11:33:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <81e17b9c-e878-1fe9-bb6f-b074d5766232@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, caleb@crome.org, timur@tabi.org, broonie@kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 05, 2017 at 02:01:17PM +0100, Maciej S. Szmigiero wrote:

> > ==Verification==
> > Theoretically, it only needs code review, build and sanity tests. I
> > have done build and sanity tests on an i.MX 6 platform by building
> > using imx_v6_v7_defconfig and testing with I2S slave/master mode.

> Due to my current workload I will be able to go through this and test
> the AC'97 mode on a UDOO board only in about a week.

This is the first round which doesn't touch program flow. If you
prefer to verify it other than merely reviewing it, I would like
to wait for your Tested-by. There will be another set to simplify
all functions and their program flows after this set gets merged.
That one will need to be fully tested.
