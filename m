From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Mon, 21 Apr 2008 15:51:09 +0100
Message-ID: <20080421145104.GB21492@sirena.org.uk>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
	<20080419112425.GA18877@sirena.org.uk>
	<20080419121838.GA1680@buzzloop.caiaq.de>
	<20080419145005.GA23492@sirena.org.uk>
	<74d0deb30804210738y7d9c38b6m885338f7551e182c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CD0F243FE
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 16:56:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74d0deb30804210738y7d9c38b6m885338f7551e182c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 21, 2008 at 04:38:58PM +0200, pHilipp Zabel wrote:

> This is interesting, what is the generic jack detect feature supposed
> to do exactly? I ask because I just export the jack detect interrupt
> to userspace via input subsystem (SW_HEADPHONE_INSERT). Will it
> replace this switch in functionality?

As far as user space is concerned I'd expect it to turn out as pretty
much exactly that, wrapping it up so that sound drivers don't need to
reproduce the code to register an input device and so on.  Devices that
can detect the type of inserted will need some additional switch types
adding.
