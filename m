From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dmaengine: Correct Makefile when
 sound is built as module
Date: Tue, 9 Oct 2012 13:15:42 +0900
Message-ID: <20121009041540.GA8237@opensource.wolfsonmicro.com>
References: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
 <5072BE20.9040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3C6A265218
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 06:15:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5072BE20.9040400@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 08, 2012 at 02:50:56PM +0300, P=E9ter Ujfalusi wrote:
> On 10/01/2012 12:29 PM, Peter Ujfalusi wrote:
> > soc-dmaengine-pcm library need to be part of the snd-soc-core in order =
to
> > be able to compile ASoC as modules when dmaengine is enabled on the pla=
tform.

> Would it be possible to schedule this patch for 3.7? I'm sure if you buil=
d any
> platform which uses dmaegine for audio and compile the audio as module you
> will also have errors about missing symbols.

As ever this sort of contentless nag is annoying rather than helpful.
