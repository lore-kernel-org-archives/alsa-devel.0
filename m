From: Caleb Crome <alsa@crome.org>
Subject: Re: How do create a dummy device for recording audio?
 Does it exist already?
Date: Thu, 22 Apr 2004 10:14:39 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4087FD7F.5010209@crome.org>
References: <200404221450.i3MEof4u006782@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404221450.i3MEof4u006782@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Caleb Crome <alsa@crome.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

StreamRipper:  Close, but no cigar.  That only works for MP3 streams, 
not for other streams, such as RealPlayer.  I have looked at 
streamripper before and it doesn't do what I want as far as I can tell.  
In the case of RealPlayer, the audio goes from Real->PCM->MP3, which I 
admit isn't great for audio quality, but I don't really care, I'm not 
trying to listen to music.  In fact, that would be an extraordinarily 
hard way to get music.  I actually want it mainly so that I can record 
NPR constantly and have 30 minutes blocks automatically encoded and 
sitting on my hard drive.  Then when I come in to a show half way, and 
what to hear the whole thing, I just grab the files and burn them to MP3 
CD.  Then I can listen to CarTalk or whatever whenever I want, on my 
terms. 

Paul Davis wrote:

>>1) Open my Player, tune to my favorite station. Use my new device for 
>>audio output.
>>2) do something like:  dd if=/dev/audiocapturepcmout count=xxx | lame 
>>--output myfile.mp3
>>    
>>
>
>streamripper is a much better option for this. its specially designed
>for this task. you are also talking about mp3->PCM->mp3 conversion,
>which is not very nice for audio quality.
>
>http://streamripper.sf.net/
>
>--p
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
