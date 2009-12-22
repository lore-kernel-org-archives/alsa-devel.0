From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Installing a "different" version of Alsa
Date: Tue, 22 Dec 2009 12:58:47 +0000
Message-ID: <20091222125847.GB8522@sirena.org.uk>
References: <mailman.3791.1261331960.2074.alsa-devel@alsa-project.org>
	<69F4A42643E24687BFFD4D3D0F485DEA@brianoffice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2686810383B
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 13:58:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <69F4A42643E24687BFFD4D3D0F485DEA@brianoffice>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Welch <Brian-Welch@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 20, 2009 at 11:34:03PM -0700, Brian Welch wrote:

> I guess I don't understand exactly what you mean by "toolchain."  I've 
> already
> contacted the people that package up the SDK and they said I should solve it

I mean the people who produce whatever embedded Linux distribution you
are using (you didn't mention?), or the user community surrounding it.
If you're having trouble getting support from them there's other
distributions out there such as the OpenEmbedded based ones which do
have more of an active user community around them:

	http://openembedded.net/

> myself.  I originally hoped that I could just re-build the kernel without 
> Alsa
> built-in, then add my new version of Alsa, but they claim that causes other
> issues (i.e. no sound at all).

If it's just the drivers you need to update it's probably easier to
merge the newer ALSA version into the kernel rather than trying to keep
an out of tree version as well, it will hopefully reduce the level of
confusion within the toolchain.
