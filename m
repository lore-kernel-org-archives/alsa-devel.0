From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3]AsoC/nuc900: patch for
 SUBSTREAM_TYPE', 'PCM_TX' and 'PCM_RX' removal
Date: Wed, 2 Jun 2010 11:40:57 +0100
Message-ID: <20100602104056.GC2457@opensource.wolfsonmicro.com>
References: <4C05F211.7070308@gmail.com>
 <1275471787.3037.28.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D23524615
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 12:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275471787.3037.28.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Wan ZongShun <mcuos.com@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 02, 2010 at 10:43:07AM +0100, Liam Girdwood wrote:
> On Wed, 2010-06-02 at 13:54 +0800, Wan ZongShun wrote:
> > This patch is to remove the 'SUBSTREAM_TYPE','PCM_TX' and 'PCM_RX' definition.
> > 
> > There is no need to redefine SNDRV_PCM_STREAM_PLAYBACK as PCM_TX,
> > the SUBSTREAM_TYPE(substream) can be deleted too, the playback or record can be
> > judged by 'if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)' directly rather
> > than 'if (PCM_TX == stype)', which makes the codes easy to read.
> > 
> > Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

Note here that you're still missing a space betwen your name and e-mail
address.

> All 

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

I've applied all the patches, since I had to fix up the changelogs
anyway I updated the ms to us in the changelog for patch 2.  Thanks.
