From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: Pops at start of song
Date: Wed, 19 Nov 2003 16:45:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBC0EA3.4050306@pianodisc.com>
References: <3FBBEB78.3030706@pianodisc.com> <3FBC0A54.1020105@cs.utoronto.ca>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBC0A54.1020105@cs.utoronto.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Apostolos Dimitromanolakis <apostol@cs.utoronto.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hm, sounds like the very definition of a hardware issue to me. ;) When I 
said "hardware issue" I wasn't refering to a bug in the hardware or 
hardware drivers... more of a "that's how it works and we're stuck with 
it".  :)

One of our other engineers has taken that exact approach.  It just seems 
strange to have to manually ramp down the voltage on the hw by the 
application manually inserting data into the pcm to do so.  If this has 
to be done w/ some soundcards and not others, why is the application 
resposible for this and not the driver or the alsa-lib?  I just figured 
it was unique with the fact we pretty much didn't do anything other than 
a snd_pcm_close() after our last snd_pcm_writei() call and that there 
were some type of snd_pcm_cleanup_everything() call that we need to make.

Thanks,
- Steve

Apostolos Dimitromanolakis wrote:
> 
> Hi,
> 
> This is not a hardware issue. The problem is that the DAC of your card 
> gets stopped in some other level than 0V and when you restart playback 
> the voltage differential causes the pop (because the output of the 
> digital to analog converter is AC-coupled). To perform a clean stop and 
> start make sure that when you start the playback, the first few bytes 
> are zero and when you stop the last few. If they are not, do a gradual  
> change of the samples (say no more that +/- 500 difference over the 
> previous sample). I think the problem is more evident in high end 
> sound-cards which have a flat frequency response down to a few Hz.
> 
> Apostolos
> 
> 
> Steve deRosier wrote:
> 
>> All,
>>
>> We're having a problem with some of our audio applications.  When a 
>> song starts playing we will often hear a loud pop out of the speakers 
>> before it plays audio.  It seems dependent upon where we stoped and 
>> the specfic content of the last song, if we hit our "stop control" and 
>> abort in the middle of the song it may pop uppon restarting or 
>> starting a new song.
>>
>> One of our engrs found if he fills the entire buffer with zeros before 
>> quitting the program, on the next start it won't pop (though that 
>> moves the pop to the end of the previous due to a disconnect/jump in 
>> the created waveform).  Unless this is a hardware issue, this doesn't 
>> seem to be the right solution to me.  So:
>>
>> * What are things that we can do in our program using the alsa pcm 
>> functions to eliminate this?  Maybe a specific function we need to 
>> call or a particular sequence?
>> * Or, is this something inherent in hardware and other than filling 
>> with zeros before we quit there's nothing we can do?
>>
>> I figure some of you have encountered this before, so maybe there's 
>> some ideas out there?
>>
>> If you're wondering what we do when a "stop" command comes in: pretty 
>> much nothing.  Basically my "ALSASender" routine ends and calls:
>> void CDSP::ClosePCM( void )
>> {
>>   // some other bookkeeping goes here <snip>
>>
>>   snd_pcm_close( hPCM );
>>
>>   if( mPCMStatus )
>>   {
>>      snd_pcm_status_free( mPCMStatus );
>>      mPCMStatus = NULL;
>>   }
>>
>>   // Non-alsa related cleanup goes here <snip>
>> }
>>
>> Also, note that we do get the same pops with using aplay.
>>
>> Thanks,
>> - Steve
>>
>> PS Takashi -> I haven't given up on my serial driver patch, I was 
>> working on it when I got interupted with something else, it should be 
>> on its way soon; thanks for your help.
>>
>>
>>
>> -------------------------------------------------------
>> This SF.net email is sponsored by: SF.net Giveback Program.
>> Does SourceForge.net help you be more productive?  Does it
>> help you create better code?  SHARE THE LOVE, and help us help
>> YOU!  Click Here: http://sourceforge.net/donate/
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
>>
> 
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
