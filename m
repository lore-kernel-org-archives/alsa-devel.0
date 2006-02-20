From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Test model
Date: Mon, 20 Feb 2006 07:32:05 +0200
Message-ID: <43F95455.1030502@akl.lt>
References: <200602192333.k1JNXCKp018481@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602192333.k1JNXCKp018481@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

> Note that this has nothing to do with the inability to make the internal
> speaker play ball on your laptop - it affects only the ability to record
> from certain widgets via the second ADC (0x05) since the existing capture list
> is for NID 0x04.

I know that. BTW one of the actions I tried last weekend was recording 
something from the microphone. And it failed too. selecting one (don't 
remember which, though) of the capture channels for capture resulted 
in continuous noise being recorded, and selecting the other one 
resulted in silence. Also, selecting both resulted in sum of these, 
hence, noise again...

Also, not sure if it's alsamixer's or driver's fault, alsamixer always 
says "Input Source 1" is "1", even though it selects the required source.

Paulo, would you please confirm this too?

Jonathan, I think that maybe the "test" model should have even more 
controls to play with, even those that may seem like should never be 
used? For example, there seem to be no checkboxes or something similar 
to control S/PDIF NIDs, or jack (pin) widgets and so on. Such controls 
might be useful for testing, when nothing else seems to work out, like 
the Acer case at the moment. In order not to clutter the default 
tester's mixer interface, maybe this (at least partially) should go to 
some kind of an "extended test" model, i don't know.

BTW, if I haven't misunderstood the datasheet, I think it says that 
S/PDIF NIDs (0x03 and 0x06, if I remember correctly) can be told to 
output Analog audio, along with the other channels. Could this 
possibly be Acer's case? I'm asking this because these were probably 
the only NIDs that I didn't even try to play with...

Best regards,

Rimas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
