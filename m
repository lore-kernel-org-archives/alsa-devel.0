From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: need help with io plugin programming: how to add delay
	?
Date: Tue, 22 Dec 2009 20:55:33 +0100
Message-ID: <4B312435.800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id C5AA724506
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 20:55:42 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 23BE24BEE9
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 20:55:40 +0100 (CET)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D+IrKcO38lKS for <alsa-devel@alsa-project.org>;
	Tue, 22 Dec 2009 20:55:39 +0100 (CET)
Received: from [192.168.1.132] (85-127-149-164.dynamic.xdsl-line.inode.at
	[85.127.149.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id 83B934BE05
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 20:55:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to write a simple alsa io plugin that takes some amount of
PCM samples and sends them to a socket in a timely manner (this would be
playback).
Later on it should work the other way round as well (recording).
(Well, actually I have been working on this for a month already but so
far I still did not manage to get a working solution.)


However, if the PCM stream comes from something prerecorded (i.e. a wav
file) there needs to be some kind of delay.
If for example the wav file would have a sampling rate of 8 kHz, 16 bit
resolution and one period should consist of 160 samples, it would be
necessary to write on period exactly each 20ms.
For this reason delay needs to be added somewhere so that each 20ms
exactly one period is begin sent to the socket.
Otherwise all the PCM samples would be just immediately written to the
socket without any delay.


I read a lot of other alsa plugin code but still I have found no way to
properly solve the delay problem.

* Where and how do I need to add delay ??


My first approach was to add delay by sleeping in the transfer callback
function.
After I had implemented that solution (and it did not work that well) I
was told that this is not the proper way to do it.

* What is the proper way then ?


I was told that the alsa plugin framework is poll based and I should
come up with a poll based solution.
However, I can not just let the alsa io plugin poll for POLLOUT on the
socket as this would not add any delay at all.
(It would just wait until new data can be written to the socket.)



After looking at the bluetooth alsa plugin I came up with another idea
(and my second approach):

Basically it should be possible to create an independent timing thread
in the alsa plugin that writes dummy data (e.g. a single byte) to a pipe
each period (thus in my case each 20ms).

The plugin would then poll for POLLIN on the above mentioned pipe and
poll for POLLOUT on the socket at the same time.
This way the transfer callback function would be called if and only if
the following two conditions are met:

	* 20 ms period time has passed
	* the socket can accept new data

* Would this solution be the proper way ?


Another solution (my third one already) would be to introduce *no* delay
in the alsa plugin itself, but do everything in the application that is
listening on the socket.
For this reason the application would read one period, process the data
and then sleep for the rest of the time until the time for one period
(i.e. 20ms) is over.
After that the next period is read from the socket and so forth.
The alsa plugin would then "automatically" write new data to the socket
each time the application listening to that socket reads data and there
is free space in the socket send buffer.

* Once again, would this be a proper solution ?

* If so, how do I know when to increment the hardware pointer ?
  (- After the send() call in the transfer callback function ?
   - Using an independent thread in the plugin that just increments the
     hardware pointer each 20ms ?)
   - something even more complex ?)

My guess is that the third solution (delay is added in the application
that listens to the socket) might work well as the delay is added at the
end of the "audio processing chain" which makes it less sensitive to
delays that are introduced in between.

* Is this correct ?

I would appreciate any help as I have invested way too much time in this
already.

cheers,
stefan
