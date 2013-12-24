From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/19] ASoC: s6000: Don't set unused struct
 snd_pcm_hardware fields
Date: Tue, 24 Dec 2013 12:02:45 +0000
Message-ID: <20131224120245.GV30815@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-13-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 782C92610D7
 for <alsa-devel@alsa-project.org>; Tue, 24 Dec 2013 13:02:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1387545625-19240-13-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 20, 2013 at 02:20:19PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.
