From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Using alsa-lib for timing
Date: Tue, 26 Nov 2002 22:27:08 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE35A8C.5030109@superbug.demon.co.uk>
References: <15829.12424.589673.766811@rls.cx>	<E18Cmqi-00030b-00@sc8-sf-list1.sourceforge.net> <15843.3774.714782.12089@rls.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <15829.12424.589673.766811@rls.cx>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Spier <rspier@pobox.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Robert Spier wrote:

>Paul, 
>
>    Thank you for your clear explanation.  I've submitted a small
>    documentation patch to the sf.net project which might prevent the
>    next person who comes along from falling into the same trap.
>
>  
>
>>the basic problem is that you are going about this in the wrong
>>way. there have been many discussions here and on LAD about how to do
>>this sort of thing. its not easy. your first and most basic problem is
>>that you are trying to sync two clocks (the video frame clock and the
>>audio frame clock) that do *not* run in sync. any solution that starts
>>with this as its approach is going to fail, for better or for worse.
>>    
>>
>
>    We've gone back to our standby method of timing everything off the
>    audio, using polling to trigger the RTC for a per-frame delay.
>    It's CPU intensive, but works well enough for our purposes.
>    (Although definitely sub-optimal and quite nasty.)
>
>-R
>  
>
One approach I have taken to try and overcome the problem of using audio 
card clocks and system clocks, it that I use resampling. So I use the 
system clock to sync audio/video, and then let the audio card ask for 
samples, using a sort of callback method from alsa, similar to the way 
jack gets alsa to simulate a callback interface.
If my application notices that the sound card is outputting samples too 
quickly(I.E. audio hardware clock is slightly faster than the system 
clock), it does some resampling, thus making the sound card have to 
output more samples. As the sound card now has more samples, it then is 
kept in step with the system clock.
I have found that the linux system clock is always more accurate than 
most sound card clocks, so I believe that this approach is quite good.

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
