From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: How do create a dummy device for recording audio? Does it exist already?
Date: Thu, 22 Apr 2004 10:50:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404221450.i3MEof4u006782@dhin.linuxaudiosystems.com>
References: <4087CC4B.80402@crome.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 22 Apr 2004 06:44:43 PDT."
             <4087CC4B.80402@crome.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Caleb Crome <alsa@crome.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>1) Open my Player, tune to my favorite station. Use my new device for 
>audio output.
>2) do something like:  dd if=/dev/audiocapturepcmout count=xxx | lame 
>--output myfile.mp3

streamripper is a much better option for this. its specially designed
for this task. you are also talking about mp3->PCM->mp3 conversion,
which is not very nice for audio quality.

http://streamripper.sf.net/

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
