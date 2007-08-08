From: Damon Chaplin <damon@karuna.eclipse.co.uk>
Subject: Re: Problem with CME UF5 MIDI keyboard master volume
	slider
Date: Wed, 08 Aug 2007 17:36:02 +0100
Message-ID: <1186590962.3160.10.camel@localhost.localdomain>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
	<1186503487.3160.26.camel@localhost.localdomain>
	<1186560704.30326.1204316209@webmail.messagingengine.com>
	<1186581239.3160.6.camel@localhost.localdomain>
	<1186584284.2915.1204373387@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mra05.ch.as12513.net (mra05.ch.as12513.net [82.153.254.73])
	by alsa0.perex.cz (Postfix) with ESMTP id C176E10389D
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 18:36:39 +0200 (CEST)
In-Reply-To: <1186584284.2915.1204373387@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-08-08 at 16:44 +0200, Clemens Ladisch wrote:
> Damon Chaplin wrote:
> > On Wed, 2007-08-08 at 10:11 +0200, Clemens Ladisch wrote:
> > > Please show the output of "amidi --dump" with some key presses after
> > > you've used the master volume slider.
> > 
> > Here's a few key presses, then some master volume slider movement, then
> > another few keypresses:
> > 
> > 90 2B 4A
> > 80 2B 24
> > 90 30 34
> > 80 30 27
> > 90 34 3A
> > 80 34 3A
> > F0 01 7F 7D
> > F0 01 7F 7C
> > F0 01 7F 7B
> > F0 01 7F 7A
> > F0 01 7F 79
> > F0 01 7F 78
> > F0 01 7F 77
> > F0 01 7F 76
> > 90 2D 29
> > 80 2D 1D
> > 90 30 29
> > 80 30 24
> > 90 34 49
> > 80 34 34
> 
> All keypresses arrive correctly.
> 
> Looks like a bug in the keyboard's firmware.

Yes, I wouldn't be completely surprised. They did seem to have some
driver issues on Windows.


> Please check whether the later keypresses arrive when using aseqdump.

This is a few keypresses, then some slider movement, and more
keypresses. It looks like it's got completely confused by the input:


Waiting for data. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
 20:1   Note on                 0  41  42
 20:1   Note off                0  41  18
 20:1   Note on                 0  45  58
 20:1   Note off                0  45  20
 20:1   Note on                 0  48  58
 20:1   Note off                0  48  33
 20:1   Note on                 0  43  65
 20:1   Note off                0  43  32
 20:1   System exclusive          F0 01 7F 39 F0 01 7F 3C F0 01 7F 3D F0
01 7F 3E F0 01 7F 41 F0 01 7F 43 F0 01 7F 46 F0 01 7F 49 F0 01 7F 4D F0
01 7F 51 F0 01 7F 54 F0 01 7F 58 F0 01 7F 5C F0 01 7F 5F F0 01 7F 64 F0
01 7F 67 F0 01 7F 6B F0 01 7F 6E F0 01 7F 71 F0 01 7F 72 F0 01 7F 73 F0
01 7F 74 F0 01 7F 70 F0 01 7F 6B F0 01 7F 64 F0 01 7F 5E F0 01 7F 57 F0
01 7F 4F F0 01 7F 47 F0 01 7F 40 F0 01 7F 3F F0 01 7F 45 F0 01 7F 4B F0
01 7F 50 F0 01 7F 54 F0 01 7F 5A F0 01 7F 5E F0 01 7F 60 F0 01 7F 5A F0
01 7F 52 F0 01 7F 49 F0 01 7F 40 F0 01 7F 3C F0 01 7F 32 F0 01 7F 29 F0
01 7F 23 F0 01 7F 20 F0 01 7F 26 F0 01 7F 2E F0 01 7F 36 F0 01 7F 3D F0
01 7F 41 F0 01 7F 49 F0 01 7F 4F F0 01 7F 53 F0 01 7F 50 F0 01 7F 48 F0
01 7F 3F F0 01 7F 3A F0 01 7F 2E F0 01 7F 23 F0 01 7F 1C F0 01 7F 17 F0
01 7F 19
 20:1   System exclusive          F0 01 7F 20 F0 01 7F 29 F0 01 7F 33 F0
01 7F 3C F0 01 7F 3E F0 01 7F 45 F0 01 7F 48 F0 01 7F 49 90 2F 1C 80 2F
1C 90 2F 40 80 2F 29 90 32 2F 90 30 29 80 30 0C 80 32 24 90 32 4D 80 32
29 90 32 4A 80 32 2A 90 32 3D 80 32 32 90 32 41 80 32 37 90 32 47 80 32
36 90 32 49 80 32 27 90 2D 35 90 35 38 80 2D 0B 90 34 26 80 35 0C 90 2D
06 80 34 0B 90 35 4D 80 2D 11 90 34 36 90 32 3C 90 2D 44 80 35 0F 80 34
1F 80 32 0A 90 35 4A 80 2D 1A 90 34 41 90 32 26 80 35 1D 90 2D 46 80 34
1A 80 32 0E 90 35 54 80 2D 17 90 34 31 90 32 3C 80 35 1C 90 2D 3C 80 34
13 80 32 17 80 2D 15 90 35 43 90 34 49 90 32 44 80 35 1C 90 2D 47 80 34
19 80 32 1E 90 35 36 80 2D 1D 90 34 3D 90 32 4D 80 35 1C 90 2D 49 80 34
16 80 32 1F 80 2D 1A 90 34 54 90 35 0A 90 32 4A 80 35 14 90 2D 47 80 34
27 80 32

Is it possible to workaround the problem?

Damon
