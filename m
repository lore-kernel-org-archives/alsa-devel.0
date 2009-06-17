From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: LSB inclusion of ALSA
Date: Wed, 17 Jun 2009 10:52:38 +0200
Message-ID: <4A38AED6.4060009@ladisch.de>
References: <4A3296D0.4080701@novell.com>	<4A378931.8010102@ladisch.de>
	<s5h3a9z46ne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5E2DB103848
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 10:52:43 +0200 (CEST)
In-Reply-To: <s5h3a9z46ne.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Robert Schweikert <rschweikert@novell.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > There is a loopback driver, but it is not part of the LSB specification.
> > This means that a test using this driver would not work with any
> > alternate ALSA implementation.
> 
> Yes, I mentioned about this in the last conf call with LSB guys.
> 
> Another candidate is alsa-lib file plugin (and null plugin).  They can
> be used to simulate in a certain level of I/O.

I don't think that LSB guarantees the availability of these plugins
either.  (And they don't get the timing correct, but maybe we don't care
about that.)

> > I can easily imagine LSB-compliant computers that do not have any sound
> > card (e.g., most servers).  Even if the ALSA interface (i.e., libasound)
> > is installed, some parts cannot be used in any meaningful way.  What is
> > a test supposed to do in this case?  It could just exit with "pass",
> > but this wouldn't actually _test_ much.
> 
> The test can never cover 100% all real cases.
> So, the primary question is: what kind of test do we need.
> 
> From the LSB perspective, I suppose, the API compatibility is the
> biggest issue.  The functionality, either working or not on the real
> hardware, is a subsystem bug.  And, the subtle tests would be likely
> needed done manually with the real hardware.

So ALSA's LSB tests would be like the Qt4 tests, whose description is:
| check run-time presence of interfaces and absence of critical errors
| in simple use cases

> > (Hmmm, a dummy ALSA implementation that just returns -ENODEV when the
> > application tries to open a device would be compliant, because it cannot
> > be distinguished from the 'real' ALSA with no installed sound card.  :-)
> 
> You mean the dummy sound driver?

No.  I meant that the ALSA interfaces, in case they are only required
for strict LSB compliance but not for actual sound output, could be
implemented like this to save memory:

	int snd_pcm_open(...)
	{
		return -ENODEV;
	}

This is purely theoretical, but my point is that this would be a
conforming implementation of the ALSA interface.


Best regards,
Clemens
