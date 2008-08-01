From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 19:01:01 +0100
Message-ID: <20080801180059.GE11735@sirena.org.uk>
References: <20080801160213.GB11735@sirena.org.uk>
	<482977.63508.qm@web50112.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8912E24511
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 20:01:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482977.63508.qm@web50112.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Mahajan <nitinm76@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 10:27:24AM -0700, Nitin Mahajan wrote:

> If Master is not there, logically are the enough for playback?

> amixer set 'PCM' 255 unmute
> amixer set 'Headphone' 255 unmute

No, you also need to ensure that the signal is routed from the DAC to
the headphone output.
