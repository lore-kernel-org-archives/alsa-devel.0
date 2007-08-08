From: Damon Chaplin <damon@karuna.eclipse.co.uk>
Subject: Re: Problem with CME UF5 MIDI keyboard master
	volume	slider
Date: Wed, 08 Aug 2007 14:53:59 +0100
Message-ID: <1186581239.3160.6.camel@localhost.localdomain>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
	<1186503487.3160.26.camel@localhost.localdomain>
	<1186560704.30326.1204316209@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mra05.ch.as12513.net (mra05.ch.as12513.net [82.153.254.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EBC0103951
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 15:54:26 +0200 (CEST)
In-Reply-To: <1186560704.30326.1204316209@webmail.messagingengine.com>
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

On Wed, 2007-08-08 at 10:11 +0200, Clemens Ladisch wrote:
> Damon Chaplin wrote:

> > If I move the slider I get this in rawmidi (4 lines for each increment):
> > 
> > read f0
> > read 01
> > read 7f
> > read 7e
> > 
> > read f0
> > read 01
> > read 7f
> > read 7d
> > 
> > Are they valid MIDI messages?
> 
> No.  These look like the first four bytes of master volume sysex
> messages, but anything after the first four bytes seems to be missing.
> Sysex messages end with a F7 byte, so it's possible that the following
> data gets misinterpreted.
> 
> Please show the output of "amidi --dump" with some key presses after
> you've used the master volume slider.


Here's a few key presses, then some master volume slider movement, then
another few keypresses:

90 2B 4A
80 2B 24
90 30 34
80 30 27
90 34 3A
80 34 3A
F0 01 7F 7D
F0 01 7F 7C
F0 01 7F 7B
F0 01 7F 7A
F0 01 7F 79
F0 01 7F 78
F0 01 7F 77
F0 01 7F 76
90 2D 29
80 2D 1D
90 30 29
80 30 24
90 34 49
80 34 34

Damon

(By the way another UF5 user has noticed the same problem, so it isn't
just my system. And I'm using Fedora 6, which has alsa-lib-1.0.12-2.fc6)
