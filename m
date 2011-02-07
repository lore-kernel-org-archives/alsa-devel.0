From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 7 Feb 2011 13:52:26 +0000
Message-ID: <20110207135225.GJ10564@opensource.wolfsonmicro.com>
References: <1297075922.15320.31.camel@masi.mnp.nokia.com>
 <4D4FDED0.7070008@redhat.com>
 <20110207120234.GE10564@opensource.wolfsonmicro.com>
 <4D4FEA03.7090109@redhat.com>
 <20110207131045.GG10564@opensource.wolfsonmicro.com>
 <4D4FF821.4010701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D4FF821.4010701@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: matti.j.aaltonen@nokia.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 07, 2011 at 11:48:17AM -0200, Mauro Carvalho Chehab wrote:
> Em 07-02-2011 11:10, Mark Brown escreveu:

> > There is an audio driver for this chip and it is using those functions.

> Where are the other drivers that depend on it?

Nothing's been merged yet to my knowledge, Matti can comment on any
incoming boards which will use it (rx51?).

Note that due to the decomposed nature of embedded audio hardware the
audio part of the chip needs to be represended within the audio
subsystem even if the control were all in the media side - this isn't an
isolated bit of hardware on an expansion card, it's fairly tightly
coupled into the rest of the system.
