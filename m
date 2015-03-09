From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [DAPM question] DAPM support for single input
	multiple outputs
Date: Mon, 09 Mar 2015 09:53:50 +0100
Message-ID: <54FD5F9E.3080606@metafoo.de>
References: <54FD5C1D.9030909@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-061.synserver.de (smtp-out-074.synserver.de
 [212.40.185.74])
 by alsa0.perex.cz (Postfix) with ESMTP id EF1A32605C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:53:44 +0100 (CET)
In-Reply-To: <54FD5C1D.9030909@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/09/2015 09:38 AM, Qiao Zhou wrote:
> Hi Mark,
>
> I have one question and need your suggestion. Thanks in advance.
>
> In our DSP, one stream path is like this: There is one bit controlling
> whether a signal A goes to A_out or B_out. That's the reverse case of
> DAPM_MUX(multiple inputs, single output).
>
> One way is to use two switches but it seems not good since two switches
> control the same bit. It's strange. Do you have any opinion about such
> requirement support?

There is currently no support for a demux. But it shouldn't be too hard to 
add one in the DAPM core, if you want to take a try at it.

A demux would behave very similar to a mux, except that you'd reverse 
sources and sinks. The only thing that is a bit tricky is that we only have 
one control element per path and currently it always belongs to the sink. 
For a demux it needs to be long to the source. This means you can't have a 
mixer directly connected to the same path as a demux and the core needs to 
make sure that that doesn't happen.

- Lars
