From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Warn when control names are truncated
Date: Wed, 29 Oct 2008 14:33:16 +0000
Message-ID: <20081029143316.GA27763@rakim.wolfsonmicro.main>
References: <1225289694-25584-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hej1zmq59.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9375124443
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 15:33:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hej1zmq59.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 29, 2008 at 03:28:50PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > -	if (ncontrol->name)
> > +	if (ncontrol->name) {
> > +		if (strlen(ncontrol->name) > sizeof(kctl.id.name))

> This should be '>=' since strlen() doesn't count the terminator.

Oh, sorry - I'd misread strlcpy() as strncpy() (which would mean that
the termination character wasn't needed).
