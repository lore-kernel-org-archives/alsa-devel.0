From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [PATCH] ASoC: wm8741: Remove unneeded startup()
 callback
Date: Tue, 31 Jan 2017 21:38:16 +0100
Message-ID: <6a27e916-4119-a920-6317-cf9bfa18f340@gmx.de>
References: <1485560145-12908-1-git-send-email-ce3a@gmx.de>
 <20170130092259.GE1754@localhost.localdomain>
 <1c9d48c3-770b-3048-23d2-afc22f221077@gmx.de>
 <20170131094931.GG1754@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 08F98267395
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:38:49 +0100 (CET)
In-Reply-To: <20170131094931.GG1754@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Jan 2017 09:49:31 +0000, Charles Keepax wrote:
> On Mon, Jan 30, 2017 at 11:56:52PM +0100, Sergej Sawazki wrote:

>> After clearing the sysclk, the codec should 'pretend' to support all
>> rates, right? (no sysclk -> no rate constrains)

> Indeed yes, so a normal pattern would often be setting a sysclk
> rate in set_bias_level(on the way up)/hw_params and clearing it in
> set_bias_level(on the way down). That way whilst the device is
> powered up it is fixed at a certain rate so as not to disrupt any
> running audio but whilst powered down you are free to start it up
> at any rate.

Thanks Charles, it is clear now, sorry for the noise.

Sergej
