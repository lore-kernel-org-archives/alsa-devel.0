From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about ASOC codec drivers
Date: Tue, 18 Jan 2011 19:19:23 +0000
Message-ID: <20110118191923.GB17591@sirena.org.uk>
References: <AANLkTim-3xObWzoF4aMUA6umYcD=wDhvY+mChqQhU=JY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EC422417E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 20:19:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTim-3xObWzoF4aMUA6umYcD=wDhvY+mChqQhU=JY@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neiljay@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 05:35:22PM +0000, Neil Jones wrote:

> tansen_input_select[] array of strings which only has 3 entries, so it
> blows up (e->max = 7??).

This...

> also shouldn't the strcpy by a strncpy as we are copying to a fixed
> 64byte buffer ?

There's rather a lot of strcpy() calls in the kernel; perhaps you could
be more specific?  Ideally if you think there's a change that should be
made please post a patch.

> static const struct soc_enum tansen_ip_enum =
> SOC_ENUM_SINGLE(TANSEN_TM_IP_TOP2, 4, 0x7, tansen_input_select);

...is exactly what you told the driver to do.  You've told the core
there are seven items in the enumeration so it's expecting an array of
seven strings.
