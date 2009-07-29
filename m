From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Using Alsa for AD1981b on 9263
Date: Wed, 29 Jul 2009 10:08:07 +0100
Message-ID: <200907291008.07528.gineera@aspect135.co.uk>
References: <33A0EEB8D50198449794A1AB9DEB1E01866417CA0C@copuex01.coreobjects.com>
	<20090728113906.GC26452@sirena.org.uk>
	<33A0EEB8D50198449794A1AB9DEB1E01866417CB9C@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ttsmtp.cpwnetworks.com (ttsmtp-4.cpwnetworks.com
	[62.24.128.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 667E5103847
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 10:57:15 +0200 (CEST)
In-Reply-To: <33A0EEB8D50198449794A1AB9DEB1E01866417CB9C@copuex01.coreobjects.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 29 July 2009 08:31, Shilpa Kedar Walvekar wrote:
> Hi Mark,
>
> I built the alsa lib with " --without-versioned". But still if I give aplay
> -l, I get following:
>
> # aplay -l
> **** List of PLAYBACK Hardware Devices ****
> ALSA lib conf.c:2700:(snd_config_hooks_call) Cannot open shared library
> (null) ALSA lib conf.c:3079:(snd_config_update_r) hooks failed, removing
> configuration aplay: device_list:232: control open (0): No such file or
> directory
>
> Atmel is not responding for this issue. I have already placed a query on
> Atmel forum as well. But no reply from there.

During my work using ALSA on ARM the Alsa-lib configure option was

	--with-versioned=no

but maybe either works.  There are a couple of other possibilities here:-

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-August/009898.html

HTH

Alan
