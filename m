From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsactl adds volume controls?
Date: Wed, 29 Sep 2010 19:09:37 +0100
Message-ID: <20100929180937.GD19087@sirena.org.uk>
References: <s5hlj7ont8e.wl%tiwai@suse.de> <4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 452EF24395
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 20:09:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <i7viav$kjb$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010 at 03:26:38PM +0100, Colin Guthrie wrote:

> 2. Using the UCM system to indicate whether a mixer element is relevant
> or not is a potential nice solution in the future, but it's not
> available now and it will also require that UCM metadata is available.

...

>  3. Add an API to know whether a mixer element is active (IMO
> is_writable() is insufficient. If the current value of PCM says it's set
> to e.g. -28dB then we need to believe what it says. Even if we decide
> not to write new values to PCM mixer, we have to believe what it says -
> we is_writable() does not solve the overall problem of knowing the
> ultimate product of the various attenuations in the pipeline).

I think a new API is called for here - the basic problem we've got is
that while we do have a fairly good idea of how the controls are
conected to audio routes inside the kernel for HDA and for embedded
stuff we've no way of exposing this to the userspace applications.  This
is the root cause of a lot of the hassle here, we don't know which
controls are involved in a given audio path reliably and we don't know
if there are additional gain stages in the path.  I see this as separate
to the UCM thing with saying which control you should use for adjusting
a particular use case - UCM says "use this as your master volume for
headphone" or whatever which is separate to determining the total system
gain through the audio path.

There's some time in the LPC audio track discussion set aside for doing
some requirements gathering on this.
