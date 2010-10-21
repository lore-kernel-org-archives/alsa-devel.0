From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Questions - MUTE and PLAYBACK RATE
Date: Thu, 21 Oct 2010 14:39:46 +0200
Message-ID: <4CC03492.30908@ladisch.de>
References: <102125.36145.qm@web120512.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B1331243F8
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:38:41 +0200 (CEST)
In-Reply-To: <102125.36145.qm@web120512.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Xavi Alexis <xamalek@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Xavi Alexis wrote:
> How do you use the ALSA API to mute the MICROPHONE?
> How do you use the ALSA API to mute the SPEAKER?

These questions assume that "the MICROPHONE" and "the SPEAKER" actually
exist.  However, there are cards that have none, or more than one, or
that cannot be muted, or where the muting isn't controllable by
software.

In the general case, these settings should be controlled by the user
with a mixer application.

What are you trying to do?

> How do you reduce the playback latency or delay?

Reduce the buffer size.  However, this increases the danger of buffer
overruns.

You need low latency only when you are generating sounds in real time in
response to external events.

> I want the audio played as soon as it is read or something close to that.

Does "read" mean "read from disk" or "capture"?


Regards,
Clemens
