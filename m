From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: jack connection decision
 with different insertion logic
Date: Mon, 4 Jul 2016 10:43:06 +0800
Message-ID: <5779CD3A.4020909@nuvoton.com>
References: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmUhvWrm6ivTs4Ujp2_A8o81A12L0gPUDay0Bv9PVAkbug@mail.gmail.com>
 <5774CF97.4010203@nuvoton.com> <20160701155734.GV6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F41265876
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 04:43:12 +0200 (CEST)
In-Reply-To: <20160701155734.GV6247@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, Ben Zhang <benzh@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 CTLin0 <CTLIN0@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>, MS40 MHKuo <MHKuo@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

On 7/1/2016 11:57 PM, Mark Brown wrote:
> On Thu, Jun 30, 2016 at 03:51:51PM +0800, John Hsu wrote:
>
>   
>> Yes, it'll be more readable. I have a question. Why to add !! in
>> front of bit wise operation? What does it mean?
>>     
>
> It's redundant in almost all cases.  It translates an integer value
> into a 0/1 value (so if you've got a value of 2 it'll end up as 1) by
> doing a double not.  This very rarely matters unless you're storing the
> value in an integer and comparing it to 1 to check for truth, otherwise
> C will translate any non-zero value into true in any logic context.
>   

Thank you for the explanation. I get the purpose now and will change
the expression of function for clear intent.
