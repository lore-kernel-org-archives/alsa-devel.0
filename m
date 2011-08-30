From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: Add device tree binding for
	WM8770
Date: Tue, 30 Aug 2011 15:48:44 +0000
Message-ID: <CAOZdJXUQpyvxOVgS9mPnMwJM1TNF-X+zOVkOsDqJM_oBNQih0Q@mail.gmail.com>
References: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id F1121246E1
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 17:48:51 +0200 (CEST)
In-Reply-To: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <C1A7647CF199834BA5FDF160448D752C@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2011 at 8:27 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0Documentation/devicetree/bindings/sound/wm8770.txt | =A0 16 ++++++++++=
++++++

I don't think we should have a separate text file for each codec.
We'll soon have dozens of files that are almost identical.  Can't we
have one text file that describes most of the codec nodes, and only
add new text files for exceptions?

-- =

Timur Tabi
Linux kernel developer at Freescale
