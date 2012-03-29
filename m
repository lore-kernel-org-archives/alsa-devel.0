From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question on strict sequence followed for
 trigger
Date: Thu, 29 Mar 2012 12:19:10 +0100
Message-ID: <20120329111910.GA2434@sirena.org.uk>
References: <1ea6fbaaca7ffeaa7b7325f18fe4e959.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 063431043E0
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 13:19:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1ea6fbaaca7ffeaa7b7325f18fe4e959.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gsantosh@codeaurora.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2012 at 05:25:14PM -0700, gsantosh@codeaurora.org wrote:
> Hi All,

*ALWAYS* CC maintainers.  Mails sent to the mailing list are likely to
be ignored.

> In some scenarios we may require the sequence to be the other case to make
> sure the underlying DSP / codec is configured and triggered properly. I
> have a requirement that this sequence has to be
> 1)        Codec_dai
> 2)        Cpu_dai
> 3)        Platform dai

> Will this call sequence can be changed or there is no room to change this
> sequence.

You'll need to be more concrete about what you're actually trying to
achieve.
