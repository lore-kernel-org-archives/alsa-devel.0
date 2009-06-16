From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: LSB inclusion of ALSA
Date: Tue, 16 Jun 2009 13:59:45 +0200
Message-ID: <4A378931.8010102@ladisch.de>
References: <4A3296D0.4080701@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D5006245A4
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 13:59:52 +0200 (CEST)
In-Reply-To: <4A3296D0.4080701@novell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Schweikert <rschweikert@novell.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Robert Schweikert wrote:
> Currently ALSA is a trial use module for LSB
> (http://www.linuxfoundation.org/collaborate/workgroups/lsb) 4.0 and it
> is the intention to make ALSA mandatory with the LSB 4.1 release
> targeted for Q1 2010. One of the requirements of a mandatory module is
> the existence of a test suite for the module that covers a good chunk of
> the interfaces provided by the LSB spec. An initial exploratory look at
> the existing test cases showed that tests appear to be tied to hardware
> drivers and are interactive.
> 
> Is this initial impression correct?

Yes.

> From an LSB testing perspective, interface testing is  very important;
> i.e. I call the interface with the arguments required and I get the
> expected result back.

In the case of a hardware interface library like libasound, there is not
always a result that comes back where it could by easily tested.

While many parts of the library can be tested without special hardware
(config, sequencer+MIDI, timers), the parts that are most likely to be
used (PCM, mixer) require at least some kernel driver and contain many
functions that are used to handle hardware differences.

> 1.) Is there interest from the community side to participate in this
> effort and accept patches?

I'm just an individual and cannot speak for "the community", whatever
that is, but there is certainly interest to accept patches.

> 2.) Is it reasonable to expect that the existing tests can be used in
> some way by using a dummy sound device or a sound loop device to verify
> output?

There is a loopback driver, but it is not part of the LSB specification.
This means that a test using this driver would not work with any
alternate ALSA implementation.

I can easily imagine LSB-compliant computers that do not have any sound
card (e.g., most servers).  Even if the ALSA interface (i.e., libasound)
is installed, some parts cannot be used in any meaningful way.  What is
a test supposed to do in this case?  It could just exit with "pass",
but this wouldn't actually _test_ much.

(Hmmm, a dummy ALSA implementation that just returns -ENODEV when the
application tries to open a device would be compliant, because it cannot
be distinguished from the 'real' ALSA with no installed sound card.  :-)

> 3.) Would the community be more comfortable if this is an effort that
> creates new tests separate from the existing HW focused tests?

The current interactive tests are mostly intended to test drivers, not
the interface.  I don't think it would be desirable or even possible to
integrate them into a test suite with strict pass/fail requirements.

> 4.) Is anyone interested in helping with this effort, writing tests,
> answering questions about ALSA for those not familiar with the interface
> and or sound in general?

Yes.

Since most of libasound is somewhat undocumented (the doxygen reference
is just a skeleton), I'm wondering who is going to write the tests ...


Best regards,
Clemens
