From: pl bossart <bossart.nospam@gmail.com>
Subject: ALSA full-duplex questions
Date: Thu, 5 Nov 2009 14:40:27 -0800
Message-ID: <6160a5130911051440p786d6795o45fc5f224771e4ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 46FE02448B
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 23:40:31 +0100 (CET)
Received: by pzk14 with SMTP id 14so300655pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 14:40:29 -0800 (PST)
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
I have a very low-latency full-duplex application where I would like
up- and downlink to be synchronous, i.e. period events happen at the
same time for capture and playback. This would minimize the number of
wake-ups and enable the platform to go to low power.
I thought snd_pcm_link() would enable this coupling between capture
and playback, but it looks like it only buids a list of linked devices
and uses this information for state transitions. Said transitions
don't look quite atomic by looking at the code. The
alsa-lib/test/latency.c code even tries to measure the difference
between the number of samples read/written.
In short the question is whether I can force a synchronous behavior
from my application, or if I need to roll up my sleeves and fix the
drivers to see this behavior?
Another solution I thought of would be to disable the period events on
one of the devices, and handle both devices at once when one period
event fires. But I am not sure you can disable all events for an audio
device (was on the wish list of Lennart, not sure if it became
reality?)
Thanks for your feedback.
- Pierre
