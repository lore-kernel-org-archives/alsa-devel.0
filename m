From: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Subject: sequencer buffer
Date: Fri, 07 Nov 2003 12:00:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAB7B68.8020007@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello NG,

again I've got a question regarding the ALSA midi sequencer. I tried to 
generate Midi time code. For that, I allocated a queue, started it and 
then filled it up with a couple of midi quarter frame messages. Each 
messages had got a timestamp containing the (real/absolute) time, at 
which the message should be sent by the queue. After filling the queue, 
I drained the buffer and tried to let the process sleep until 
snd_seq_event_output_pending( handle ) falls below a given value (I 
tried 500). But I realized, that the buffer size is never decremented, 
even if the queue outputs events.

The first 7 seconds of output seem to be ok (I control the output on a 
harddisk recorder which just reads the incoming midi time code and 
displays it). But then I get "Resource temporarily unavailable" errors 
when enqueueing another quarter frame event. I think, thats because the 
output buffer is full. But why isn't an event extracted from buffer when 
it is sent by a queue?

Thanks for answers,

Bernhard

-- 

---------------------------------
Bernhard Gerlach
Fraunhofer AEMT
Am Helmholtzring 1 (Haus M)
98693 Ilmenau
Germany

mail: gerlacbd@emt.iis.fhg.de
---------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
