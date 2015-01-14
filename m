From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH v2] ALSA: ASoC: soc-compress.c: fix NULL
	dereference
Date: Wed, 14 Jan 2015 08:00:57 +0000
Message-ID: <54B62239.1020009@imgtec.com>
References: <1421147933-21802-1-git-send-email-qais.yousef@imgtec.com>
 <20150113145931.GD3085@intel.com> <54B536BA.3070001@imgtec.com>
 <BB5B134B-1BFA-4F77-A8CC-45C0137EBF57@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA7E260832
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 09:00:59 +0100 (CET)
In-Reply-To: <BB5B134B-1BFA-4F77-A8CC-45C0137EBF57@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Hogan <james.hogan@imgtec.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/13/2015 05:21 PM, James Hogan wrote:
> On 13 January 2015 15:16:10 GMT+00:00, Qais Yousef <qais.yousef@imgtec.com> wrote:
>>
>> Will this really be helpful? I think it'll be more clutter (the
>> backtrace on metag arch is not great):
> I suspect you don't have frame pointers enabled in your kernel config. That should improve the meaningfulness of the backtrace.
>
>

I forgot about this option. Thanks.
