From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] ASoC: rsnd: fixup SSI interrupts style of
 DeviceTree
Date: Mon, 02 Jun 2014 22:39:29 +0100
Message-ID: <538CEF11.8020803@codethink.co.uk>
References: <87sinrpofv.wl%kuninori.morimoto.gx@gmail.com>
 <20140530102358.GC6241@trinity.fluff.org>
 <87k393pmvv.wl%kuninori.morimoto.gx@renesas.com>
 <20140530105321.GD6241@trinity.fluff.org>
 <87fvjrpl1g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ducie-dc1.codethink.co.uk (unknown [185.25.241.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB64265450
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 23:39:38 +0200 (CEST)
In-Reply-To: <87fvjrpl1g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ben Dooks <ben@trinity.fluff.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 30/05/14 12:23, Kuninori Morimoto wrote:
> 
> Hi Ben
> 
>>> Hmm...
>>> This driver is still under developing.
>>> And it is very difficult for me to care about out-of-tree Linux.
>>
>> Ok, but we really need to keep in mind that the DT should be kept as
>> stable as possible. We may be out of tree at the moment, but we are
>> trying our best to keep track and feed back our work. This is not
>> helped if we have to do these changes when re-basing.
>>
>> In my view this change does not help the readability, as we now have
>> a large block of interrupts, where before we could easily work out
>> which interrupt was mapped to which SSI.
> 
> OK.
> I thought that 1) current style was not good DT style
> 2) there is a chance to exchange it because upstream
> doesn't have user at this point.
> Can you accept if it can keep compatibility ?

I think the current method is the nicer, it keeps the descriptions
each ssi as close as possible to the ssi. So, in answer to #1 I
think it is the best.

In answer to #2, it would be nicer not to unless you have a good
reason to do this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
