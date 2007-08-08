From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problem with CME UF5 MIDI keyboard master volume
 slider
Date: Wed, 08 Aug 2007 16:44:44 +0200
Message-ID: <1186584284.2915.1204373387@webmail.messagingengine.com>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
	<1186503487.3160.26.camel@localhost.localdomain>
	<1186560704.30326.1204316209@webmail.messagingengine.com>
	<1186581239.3160.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DAC8A10383E
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 16:44:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186581239.3160.6.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Damon Chaplin <damon@karuna.eclipse.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Damon Chaplin wrote:
> On Wed, 2007-08-08 at 10:11 +0200, Clemens Ladisch wrote:
> > Please show the output of "amidi --dump" with some key presses after
> > you've used the master volume slider.
> 
> Here's a few key presses, then some master volume slider movement, then
> another few keypresses:
> 
> 90 2B 4A
> 80 2B 24
> 90 30 34
> 80 30 27
> 90 34 3A
> 80 34 3A
> F0 01 7F 7D
> F0 01 7F 7C
> F0 01 7F 7B
> F0 01 7F 7A
> F0 01 7F 79
> F0 01 7F 78
> F0 01 7F 77
> F0 01 7F 76
> 90 2D 29
> 80 2D 1D
> 90 30 29
> 80 30 24
> 90 34 49
> 80 34 34

All keypresses arrive correctly.

Looks like a bug in the keyboard's firmware.

Please check whether the later keypresses arrive when using aseqdump.


Regards,
Clemens
