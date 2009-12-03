From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: io plugin: playback and capture over a socket
Date: Thu, 03 Dec 2009 13:07:02 +0100
Message-ID: <4B17A9E6.8080307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id AD73B10388B
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 13:07:24 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 237B04BEE0
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 13:07:10 +0100 (CET)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IDy-3PJchlGx for <alsa-devel@alsa-project.org>;
	Thu,  3 Dec 2009 13:07:09 +0100 (CET)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id 99DD84BE05
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 13:07:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having difficulties writing a simple alsa plugin that plays and
captures from a socket.

The background is that there should be a "server" application that
processes PCM data.
In order to "connect" ALSA to that application I would like to use a socket.

I looked at the bluez bluetooth audio plugin which seems to do a similar
task.

Basically the idea is that the alsa plugin transfer callback function
just sends and receives PCM samples in periods to/from the socket
(depending on whether the plugin is used for playback or capture).

To control the timing and to increment the hw_ptr a separate thread in
the alsa plugin is used.
Basically for each period the thread will increment the hw_ptr and
signal to the alsa plugin that the next period can be written.

This signaling is done by using a pipe.
As the plugin code is poll-based I guess it needs to poll both the
socket and the pipe (which is used to communicate with the "timing" thread).

For this reason the alsa plugin would only write to the socket if the
socket is ready for writing _and_ the time for writing the next period
has come (which will be signaled by a write to the pipe by the timing
thread).

Would such a implementation work so far ?

At the moment I'm having some real difficulties as for some reason the
start callback function that would start the thread is not called at all.
My code is pretty much the same as in the bluez bluetooth audio plugin.

cheers,
stefan
