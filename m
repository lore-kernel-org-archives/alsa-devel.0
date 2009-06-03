From: Glyn Adgie <glyn@castro-design.co.uk>
Subject: Sequencer timestamps for soft synth app
Date: Wed, 03 Jun 2009 09:55:37 +0100
Message-ID: <4A263A89.9020307@castro-design.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server1.pc (87-194-16-81.bethere.co.uk [87.194.16.81])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D73924643
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 10:55:38 +0200 (CEST)
Received: from glyn.pc (glyn.pc [192.168.4.20])
	by server1.pc (Postfix) with ESMTP id C0F8A97D51
	for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2009 09:55:37 +0100 (BST)
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

I have written a soft synth, which uses ALSA to get MIDI events, and 
Jack to do audio output. MIDI events are fetched and processed at the 
start of the Jack audio callback, then the Jack output buffers are 
filled by the synth engine. The problem I have is that, if the Jack 
buffer size is too large, the time resolution for MIDI events is too 
coarse, and this has a severe effect on rhythms.

I currently get around this by setting  up Jack for a buffer size of 64 
frames, and a sample rate of 48 kHz, giving a timing resolution of 1.33 
msec, which appears to be adequate. However, I might not always be able 
to get the desired buffer size. If the Jack buffer is some multiple of 
64 frames, the synth renders multiple 64 frame chunks until the buffer 
is filled. This takes care of audio quality. However, MIDI timing 
resolution suffers.

I am looking at using the event's timestamp, to decide when to process 
an event. For example, I might have a Jack buffer of 256 frames, so I 
want to work out whether to process an event right away, or after one 64 
frame chunk, and so on. It would appear that, in order to make this 
work, I need an initial timestamp, which I get at the start of the audio 
callback. I then compare each event's timestamp, to determine where it 
should be processed.

I cannot find an ALSA function for getting a timestamp. Perhaps I am 
missing something, or trying to do the job in the wrong way.

Regards

Glyn
