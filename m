From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Device creation order
Date: Sun, 5 Apr 2009 21:29:05 +0100
Message-ID: <20090405202904.GA6843@sirena.org.uk>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<49D5BCF6.1020407@ladisch.de>
	<20090403115647.GD15646@tango.0pointer.de>
	<20090405131605.GA31915@localhost>
	<20090405144041.GA31963@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DE35724385
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 22:29:12 +0200 (CEST)
Received: from 82-41-28-43.cable.ubr04.sgyl.blueyonder.co.uk ([82.41.28.43]
	helo=finisterre)
	by cassiel.sirena.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <broonie@sirena.org.uk>)
	id 1LqYxr-0000WR-OV
	for alsa-devel@alsa-project.org; Sun, 05 Apr 2009 21:29:12 +0100
Received: from broonie by finisterre with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1LqYxl-0001pO-Cz
	for alsa-devel@alsa-project.org; Sun, 05 Apr 2009 21:29:05 +0100
Content-Disposition: inline
In-Reply-To: <20090405144041.GA31963@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 05, 2009 at 04:40:42PM +0200, Lennart Poettering wrote:
> On Sun, 05.04.09 21:16, Wu Fengguang (fengguang.wu@intel.com) wrote:

> > - hotplug
> >   The user connected/disconnected a HDMI device.

> Wouldn't that overlap with the jack sensing API? 

Yes, although given that AIUI the HDMI port will be able to communicate
with the connected device it may make more sense to expose the connected
device to user space as what it is, or to do both.
