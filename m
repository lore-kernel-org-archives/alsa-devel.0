From: zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH 1/2] sound: q6core: Use kmemdup to replace kzalloc + memcpy
Date: Tue, 11 Sep 2018 09:13:58 +0800
Message-ID: <5B9716D6.8020307@huawei.com>
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com> <1536395780-18725-2-git-send-email-zhongjiang@huawei.com> <20180910141928.GI5856@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910141928.GI5856@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2018/9/10 22:19, Mark Brown wrote:
> On Sat, Sep 08, 2018 at 04:36:19PM +0800, zhong jiang wrote:
>> kmemdup has implemented the function that kzalloc() + memcpy() will
>> do. and we prefer to use the kmemdup rather than the open coded implementation.
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.
I will notice this next time.  Thanks

Sincerely,
zhong jiang
