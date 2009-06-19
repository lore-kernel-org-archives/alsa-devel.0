From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: LSB inclusion of ALSA
Date: Fri, 19 Jun 2009 15:43:24 +0200
Message-ID: <4A3B95FC.4020404@ladisch.de>
References: <4A3296D0.4080701@novell.com> <4A378931.8010102@ladisch.de>
	<4A3B78F4.7000407@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A87B110383E
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 15:43:34 +0200 (CEST)
In-Reply-To: <4A3B78F4.7000407@novell.com>
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
> Clemens Ladisch wrote:
> > While many parts of the library can be tested without special hardware
> > (config, sequencer+MIDI, timers), the parts that are most likely to be
> > used (PCM, mixer) require at least some kernel driver and contain many
> > functions that are used to handle hardware differences.
> 
> Understood, but this is functional testing (current tests seem to cover
> this) and would required the appropriate hardware (a gazilion sound
> cards). LSB makes no guarantees that the drivers exist and have no bugs.
> LSB does strive to guarantee that a particular interface exists and
> behaves as specified.
> 
> So for interfaces that require a driver one could test that an
> appropriate error condition is returned if no driver exists, and we
> could test that no error condition is triggered when a dummy driver is
> connected. Correct?

Yes.

This would require that the test suite has the capability to load and
unload kernel modules.  Could this ever be a problem?


Best regards,
Clemens
