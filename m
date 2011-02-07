From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire
 Speakers/Griffin FireWave surround driver
Date: Mon, 07 Feb 2011 17:57:58 +0100
Message-ID: <4D502496.5010900@ladisch.de>
References: <4D46933D.5050609@ladisch.de>	<4D4FB7C8.7090501@ladisch.de>	<4D4FB7F6.8000801@ladisch.de>
	<20110207174919.43b85e16@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 285C124491
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 17:56:57 +0100 (CET)
In-Reply-To: <20110207174919.43b85e16@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Stefan Richter wrote:
> On Feb 07 Clemens Ladisch wrote:
> > +	static const struct device_info lacie_speakers = {
> > +		.driver_name = "FWSpeakers",
> > +		.short_name = "Firewire Speakers",
> > +		.long_name = "LaCie Firewire Speakers",
> 
> FWIW, it is spelled "LaCie FireWire Speakers" in LaCie's printed material
> and on their web site, whereas their firmware programmers put "LaCie
> Firewire speakers" as model descriptor leaf into the Configuration ROM.

I took the latter as model, but capitalized "Speakers" because it's
a proper noun.  I'll change it to "W".

> Does the precise case of device_info strings matter to userspace?

Only for the driver name.  If I had used a common driver name for both,
the .conf file would have to use the short name to differentiate them.
The long name contains random junk (as far as everybody except
PulseAudio is concerned).


Regards,
Clemens
