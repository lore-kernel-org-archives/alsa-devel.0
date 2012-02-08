From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Multiple channels mapping
Date: Wed, 8 Feb 2012 11:54:04 +0000
Message-ID: <20120208115404.GB25756@sirena.org.uk>
References: <4F31C988.3090201@codeaurora.org> <s5hwr7xln03.wl%tiwai@suse.de>
	<4F323DE5.4050108@ladisch.de> <s5hvcnhllum.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E7DA103E25
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:54:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvcnhllum.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2012 at 10:23:45AM +0100, Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Takashi Iwai wrote:

> > TLVs on media controller entities.

> Well, my concern is that it might be too far from the other PCM
> stuff.  How the implementation would look like?

It would be really good if it could support dynamic remapping of
channels - for example, with most of the devices I work on you just get
a bunch of audio channels presented to the mixing core of the device and
can send them wherever it amuses you to do so at runtime, there's no
fixed assignments.
