From: "Ignacy Kasperowicz" <fikufik@gmail.com>
Subject: Problem with setting period time and buffer time.
Date: Tue, 19 Feb 2008 00:57:25 +0100
Message-ID: <9673d3ac0802181557m6bd35f28w7680c9a9a979ab67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F66224544
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 00:57:27 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 60so1977496wri.8
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 15:57:26 -0800 (PST)
Content-Disposition: inline
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

Hello.

I need to set proper period time for my application. What I need my
code to do is to play sine wave with set frequency and for exact time
of 1/1200 s (something about 834 us). When I try to set period time
for 834 us I've got this error:
Unable to set period time 834 for playback: Invalid argument .
Honestly speaking  I've got this error message no matter what value I
try to set).
The same situation take place when I try to set buffer time for
something about 1000us (so one period could fit in my buffer).

The purpose of this program is to generate sine wave for AFSK (audio
frequency-shift keying). I want to play wave for period_time (834us)
then if needed change frequency and play changed wave again for
period_time with phase shifting.

Wave generation with phase shifting for variable frequencies works,
but not with period_time I need.

Could anyone look at source and tell me why I can't set this values?

I placed code with syntax highlighting at: http://pygments.org/demo/606/ .
(Don't look at prepare_message function, it isn't used right now).

Thanks from advice.

Ignacy.
-- =

################################################
gry =B6wietlicowe drog=B1 do wy=BFszej fazy przemian.
gg:681548 jid: fik@jabbim.pl usecide.net
################################################
