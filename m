From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: FW:  question on snd_jack_report
Date: Mon, 2 Nov 2009 11:31:57 +0000
Message-ID: <20091102113157.GD29351@sirena.org.uk>
References: <DC9628ADC672424FAECF61709E90EDDE6A248081@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6675F103800
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 12:31:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <DC9628ADC672424FAECF61709E90EDDE6A248081@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Kp, Jeeja" <jeeja.kp@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 01, 2009 at 07:55:12PM +0530, Kp, Jeeja wrote:

Please don't top post and please fix your MUA to word wrap at 80
columns.  Not doing these things makes your messages much harder to read
and reply to.  I've reflowed your text into 80 columns.

> When I call snd_jack_report with the status of the jack, am monitoring
> the /dev/input/eventX (using event.c) for Userspace events when
> Headset is inserted and I don't see any events even when
> snd_jack_report() is called. Is there any specific configuration that
> is required (xorg.config)?

What is event.c?  If this is some part of the X.Org server then you'd be
better asking the X folks about how to configure and use the X server,
it rewraps the data it's getting from the kernel.
