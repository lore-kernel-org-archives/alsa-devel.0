From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] V3,
	Convert bitfields in ASOC into full int width
Date: Wed, 23 Jul 2008 22:12:18 +0100
Message-ID: <20080723211215.GA9895@sirena.org.uk>
References: <20080723195644.24806.52051.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FD6024839
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 23:12:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723195644.24806.52051.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 03:56:44PM -0400, Jon Smirl wrote:
> Convert bitfields in ASOC into full int width. This is a
> simple mechanical conversion. Two places in the DAPM code
> were fixed to properly use mask. Missing header for
> dapm_reg_event added. All codecs can build.

AFAICT there are no substantial changes on top of what I already applied?
