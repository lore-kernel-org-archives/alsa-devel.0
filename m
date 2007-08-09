From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problem with CME UF5 MIDI keyboard master volume
 slider
Date: Thu, 09 Aug 2007 10:27:11 +0200
Message-ID: <1186648031.27177.1204511703@webmail.messagingengine.com>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
	<1186503487.3160.26.camel@localhost.localdomain>
	<1186560704.30326.1204316209@webmail.messagingengine.com>
	<1186581239.3160.6.camel@localhost.localdomain>
	<1186584284.2915.1204373387@webmail.messagingengine.com>
	<1186590962.3160.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E928F1037FD
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 10:27:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186590962.3160.10.camel@localhost.localdomain>
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
> On Wed, 2007-08-08 at 16:44 +0200, Clemens Ladisch wrote:
> > Please check whether the later keypresses arrive when using aseqdump.
> 
> This is a few keypresses, then some slider movement, and more
> keypresses. It looks like it's got completely confused by the input:
> 
> Waiting for data. Press Ctrl+C to end.
> Source_ Event_________________ Ch _Data__
>  20:1   Note on                 0  41  42
>  20:1   Note off                0  41  18
>  20:1   Note on                 0  45  58
>  20:1   Note off                0  45  20
>  20:1   Note on                 0  48  58
>  20:1   Note off                0  48  33
>  20:1   Note on                 0  43  65
>  20:1   Note off                0  43  32
>  20:1   System exclusive          F0 01 7F 39 F0 01 7F 3C ...
>  20:1   System exclusive          F0 01 7F 20 F0 01 7F 29 F0 01 7F 33 F0
> 01 7F 3C F0 01 7F 3E F0 01 7F 45 F0 01 7F 48 F0 01 7F 49 90 2F 1C 80 2F
> 1C 90 2F 40 80 2F 29 90 32 2F 90 30 29 80 30 0C 80 32 24 90 32 4D 80 ...

This is a bug in ALSA's rawmidi -> sequencer parser.

> Is it possible to workaround the problem?

Only by changing the driver.  Please wait until tomorrow.


Regards,
Clemens
