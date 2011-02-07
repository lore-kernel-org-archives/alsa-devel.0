From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire
 Speakers/Griffin FireWave surround driver
Date: Mon, 07 Feb 2011 15:56:25 +0100
Message-ID: <4D500819.1020309@ladisch.de>
References: <4D46933D.5050609@ladisch.de>	<4D4FB7C8.7090501@ladisch.de>	<4D4FB7F6.8000801@ladisch.de>
	<20110207154025.13fdeba3@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A24E5243EF
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 15:55:23 +0100 (CET)
In-Reply-To: <20110207154025.13fdeba3@stein>
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
> I am going to test this driver with LaCie FireWire Speakers and Griffin
> FireWave RSN.  BTW, FireWave is a 6-channel-out device which is targeted to
> be used on OS X as either a stereo or a 5.1-Dolby-surround output.  I heard
> that the 5.1 mode is configured by a vendor-specific AV/C command.  (The
> FireWave was sold with an OS X driver; without this vendor driver it just
> works as a stereo-out soundcard with OS X' stock driver.)

Jay has already tested the FireWave in 6-channel mode; in fact, this was
the only format that the previous patch supported for the FireWave.

If OS X works with two channels without knowing that the device expects
six, this implies that the device automatically detects the format of
the incoming stream, and that sending Dolby data (which would just be
two-channel data labeled as "SPDIF") should work too.


Regards,
Clemens
