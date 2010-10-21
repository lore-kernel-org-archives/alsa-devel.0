From: Xavi Alexis <xamalek@yahoo.com>
Subject: Re: ALSA Questions - MUTE and PLAYBACK RATE
Date: Thu, 21 Oct 2010 06:24:34 -0700 (PDT)
Message-ID: <385567.69220.qm@web120509.mail.ne1.yahoo.com>
References: <102125.36145.qm@web120512.mail.ne1.yahoo.com>
	<4CC03492.30908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web120509.mail.ne1.yahoo.com (web120509.mail.ne1.yahoo.com
	[98.138.85.236]) by alsa0.perex.cz (Postfix) with SMTP id 38A9B2437E
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 15:24:36 +0200 (CEST)
In-Reply-To: <4CC03492.30908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you Clemens for your answers:

A few more questions:

What is the SPECIFIC function to reduce the BUFFER size?

When I say read ... I am reading the data over a socket ... 

Thanks again.

x




________________________________
From: Clemens Ladisch <clemens@ladisch.de>
To: Xavi Alexis <xamalek@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Thu, October 21, 2010 5:39:46 AM
Subject: Re: [alsa-devel] ALSA Questions - MUTE and PLAYBACK RATE

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
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
