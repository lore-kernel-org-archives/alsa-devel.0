From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Renamed the struct soc_enum field .mask to
	.count. The field refers to the number of enumerable entries
	instead of being a bit mask. This change makes the interface
	a more clear.
Date: Mon, 10 Nov 2008 11:32:13 +0000
Message-ID: <20081110113150.GA12804@sirena.org.uk>
References: <20081107230655.GA30750@friendly.synapse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A760B1037FF
	for <Alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 12:32:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081107230655.GA30750@friendly.synapse.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Singer <elf@synapse.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 07, 2008 at 03:06:56PM -0800, Marc Singer wrote:
> Signed-off-by: Marc Singer <elf@buici.com>

Your commit should have a subject line of less than 80 characters.  More
lengthy descriptions of the patch should then be included in the body of
the e-mail, word-wrapped to 80 characters.

> ---
>  include/sound/soc-codec.h |   14 +++++++-------

Ah, this is an ASoC v2 patch.  In mainline the datastructure doesn't
have a mask field at all; I'd rather not introduce any further
divergences between mainline and v2.
