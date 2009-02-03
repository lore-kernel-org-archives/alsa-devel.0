From: carmen <_@whats-your.name>
Subject: Re: [PATCH 1/2] [EXPERIMENTAL] Add support for
	the	latest IndigoIOx and IndigoDJx cards
Date: Mon, 2 Feb 2009 20:16:06 -0500
Message-ID: <20090203011606.GA4774@x.myhome.westell.com>
References: <20090201230320.f665cc5e.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3-v.mail.gandi.net (relay3-v.mail.gandi.net
	[217.70.178.77]) by alsa0.perex.cz (Postfix) with ESMTP id C756D2441A
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 02:18:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090201230320.f665cc5e.pochini@shiny.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun Feb 01, 2009 at 11:03:20PM +0100, Giuliano Pochini wrote:

i like your patch better, for the unique PCI ID and firmware 

enables DJx providing it is a module (so FS exists for firmware)

card 1: DJ [Indigo DJ], device 0: PCM [Indigo DJ]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7


unfortunately SampleRate is still FUBAR

eg sounds like 48000 playing @ 44.1 but adding -sr 44100 to jackd or mplayer results in the same pitch

-sr 32000 sounds pitched up (software downsampling, then card still playing at 44 or something)


if the firmware was *cough* open i might try to figure it out :)
