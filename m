From: Tejun Heo <tj@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320dac33: Remove deprecated
 create_singlethread_workqueue
Date: Wed, 31 Aug 2016 17:17:45 -0400
Message-ID: <20160831211745.GC12660@htj.duckdns.org>
References: <20160830182750.GA8074@Karyakshetra>
 <7abb8b68-760b-cf67-17a5-d120136d6ec5@ti.com>
 <20160831144408.GX12660@htj.duckdns.org>
 <88b9a137-b934-f928-535f-719cfbc9bff3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <88b9a137-b934-f928-535f-719cfbc9bff3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello, Peter.

On Wed, Aug 31, 2016 at 10:10:47PM +0300, Peter Ujfalusi wrote:
> > What kind of time frame are we talking about?  If it really needs high
> > priority, the right thing to do would be using a WQ_HIGHPRI workqueue.
> 
> In order to be tune the performance and power saving during audio playback
> lower is better, but consistency matters more to be able have stable system.
> I have some latency compensation in the code so it could tolerate some drift,
> but big spikes can cause the codec to go underflow and we can not recover from
> that w/o hard reset of the codec.

Gees, that's a brutal failure mode.

> I do believe that Linux got much better over the years since I wrote the dac33
> driver, so I'm fine with the move to system_wq. The most problematic mode (I
> think it was MODE7LP or smthing) is not upstream so this change should not
> break audio on the n9/n950.

Thanks for the explanation!

-- 
tejun
