From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can ALSA invoke a Callback ?
Date: Fri, 26 Aug 2011 16:34:00 +0200
Message-ID: <4E57AED8.7040408@ladisch.de>
References: <1314368677.30767.YahooMailClassic@web29606.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 6B67B1039B1
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 16:34:06 +0200 (CEST)
In-Reply-To: <1314368677.30767.YahooMailClassic@web29606.mail.ird.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ru Vuott <vuott@yahoo.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ru Vuott wrote:
> I would like to know how I can ask ALSA to invoke a "Callback"
> function when an Midi event arrives from an extern-device.

This is not possible.

The mechanism usually used for this is to check for events from the
MIDI device in the main message loop (which must be based on poll() or
select()).

Are you using raw MIDI or sequencer devices?  How does your program's
event handling work?


Regards,
Clemens
