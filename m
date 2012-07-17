From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH] snd-opti9xx: Implement suspend/resume
Date: Tue, 17 Jul 2012 14:31:58 +0530
Message-ID: <50052A06.9080301@st.com>
References: <201207170916.44277.linux@rainbow-software.org>
 <50052470.4060604@st.com> <201207171051.01687.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
 [207.126.144.131])
 by alsa0.perex.cz (Postfix) with ESMTP id AA083264F5F
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 11:02:02 +0200 (CEST)
In-Reply-To: <201207171051.01687.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 7/17/2012 2:21 PM, Ondrej Zary wrote:
>>>   static struct pnp_card_driver opti9xx_pnpc_driver = {
>>> >  >     	.flags		= PNP_DRIVER_RES_DISABLE,
>>> >  >     	.name		= "opti9xx",
>> >
>> >  Why this is opti why not OPTi
> It's not my code. This patch is just adding suspend/resume and not changing
> anything else.
>

Oops, sorry for this comment. I thought this line is changed by you.

~Rajeev
