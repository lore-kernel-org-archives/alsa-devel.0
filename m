From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] hda: add SW_LINEOUT_INSERT support
Date: Fri, 17 Oct 2008 14:05:05 +0100
Message-ID: <20081017130504.GE2546@sirena.org.uk>
References: <48F7F600.3040706@embeddedalley.com> <s5hd4hz69ia.wl%tiwai@suse.de>
	<20081017103857.GA2546@sirena.org.uk>
	<48F8833D.8080301@embeddedalley.com>
	<20081017123928.GD2546@sirena.org.uk>
	<48F88ABD.3010905@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ADFE24343
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 15:05:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F88ABD.3010905@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2008 at 08:53:17AM -0400, Matthew Ranostay wrote:

> Well is generally only one HP out jack, but there can be several line-out
> reported by the one instance(lineout_jack). I assume this isn't the correct usage.

Could you provide a bit more detail here?  Are you saying that the
hardware has several line outputs and can report connection status but
is unable to identify which of them is connected?
