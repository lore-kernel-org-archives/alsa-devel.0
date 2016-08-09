From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Tue, 9 Aug 2016 09:52:48 +0200
Message-ID: <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B7CD72657B1
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 09:52:53 +0200 (CEST)
In-Reply-To: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/09/2016 06:52 AM, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> These are codec duplicate functions cleanup patches - v2
> We would like to switch to "component" style base ASoC in the future
> instead of current "CPU/Codec/Platform/Card" style.
> 
> Current "codec" has its .probe/.remove, and "component" has it too.
> codec side is just relayed it to component side.
> This is the time to cleanup.

While for the widgets, routes and controls it did not really matter, I do
not think this is the right approach for probe and remove.

This is kind of sub-classing a normal design pattern found all throughout
the kernel. You have a generic callback function and a specialized callback
function that takes the type of the object that is being worked on rather
than the generic object type.

Especially done as a blind mechanical conversion like you did this is not a
cleanup. Most probe functions do not actually need to know that they work on
a CODEC.

E.g. you now have very often this kind of code:

    struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
    struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);

This could easily be replaced with

    struct tas5086_private *priv = snd_soc_component_get_drvdata(component);

But again, this indirection is not the problem we currently have with ASoC
and it's layering. This kind of cleanup should be done as a very final step
when all other CODEC specific elements have been removed from the driver.
