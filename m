From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Newbie question: Sending untimed MIDI data to ALSA
 seq
Date: Tue, 12 Jan 2010 12:39:01 +0100
Message-ID: <4B4C5F55.8010009@ladisch.de>
References: <4B490D93.1050506@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7C626103886
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 12:39:09 +0100 (CET)
In-Reply-To: <4B490D93.1050506@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Josh Lehan <alsa@krellan.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Josh Lehan wrote:
> I also looked at "amidi", which features a -S option to send in untimed
> MIDI bytes, but unfortunately, that addresses an entirely different
> namespace.  Evidently, it only speaks to "RawMIDI" devices, of which
> TiMidity is not.

Try the snd-virmidi driver.  It is intended to make sequencer ports
available as OSS midi devices, but you also get RawMIDI ports for free.


HTH
Clemens
