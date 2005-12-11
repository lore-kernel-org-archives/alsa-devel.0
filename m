From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: help on small program
Date: Sun, 11 Dec 2005 14:17:17 -0500
Message-ID: <1134328638.6019.15.camel@mindpipe>
References: <45A89E55-AA98-491F-A655-EC6D68F2DC1B@bardo.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <45A89E55-AA98-491F-A655-EC6D68F2DC1B@bardo.com.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bill <bill@bardo.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-12-11 at 11:27 -0500, bill wrote:
> hello,
> i am trying to make a small program...
> 
> basically i want to measure the ambient noise level with a microphone  
> and then
> set the level of the music playing accordingly
> a basic "IF ... THEN"  scenario
> 
> IF the microphone level is reading 15 over this 3 second sample  
> period, THEN set the music level output  to 44
> IF the microphone level is reading 20 over this 3 second sample  
> period, THEN set the music level output to 50
> etc
> 
> and want to take the output from my sound program, process it with  
> this small program,  and then feed it into the USB sound output device
> 
> bascially i'm not good enough at programming to do this
> 
> can anybody out there help me out??  i will pay CASH, beer, food ,  
> anything .... if you can save me!

Just take a look at the "aplay" and "arecord" sources, all you need is
in there.  Hint - when you run "aplay" or "arecord" with -vvv, it
displays a real time VU meter of the audio.  You just need to combine
the two into a single program, where the output level is set based on
the input level.

It seems like you could do it with 95% copy and paste.  Unfortunately I
don't have time to help you in more detail but this should get you
started.

Lee 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
