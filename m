From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: adding an external dsp under soc-dsp framework
Date: Mon, 6 Aug 2012 16:48:23 +0100
Message-ID: <20120806154822.GP16861@opensource.wolfsonmicro.com>
References: <FC1850374E3CB245B9E97002380578E0022216D4@ILMAIL01.dspg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 649B8265D9F
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 17:18:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <FC1850374E3CB245B9E97002380578E0022216D4@ILMAIL01.dspg.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ziv Haziz <Ziv.Haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 06:11:33PM +0300, Ziv Haziz wrote:

> ok thanks. This means that I need to introduce two codecs and make a dai
> link between them?
>  It doesn't really fits the dai structure - how do you suggest to do it?

No, if they're part of the same physical chip then they should be
handled internally to the device.

> ok - finger crossed you will publish an agreed interface soon -
> currently I saw in codeaurora kernel an implementation of exposing mixer
> controls, so currently this is the only option yes?

That's not upstream, standard Linux has no support for Slimbus at all.
