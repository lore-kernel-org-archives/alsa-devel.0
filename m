From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Does ASoC support sound card with multiple
 interfaces?
Date: Mon, 2 Jan 2012 20:16:44 +0000
Message-ID: <20120102201642.GA30932@sirena.org.uk>
References: <1325516773.12508.57.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4561410393B
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 21:16:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325516773.12508.57.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 02, 2012 at 08:36:13PM +0530, Ashish Chavan wrote:

Always CC maintainers!

>   I have a codec with multiple TX and RX channels. In ASoC tree, I have
> seen examples where these kind of codecs are implemented as multichannel
> codecs. Instead I want it to be treated as card with multiple

Yes, this is totally supported.  There are quite a few examples of this
in the tree.  Your CODEC driver should just implement one DAI per audio
interface.
