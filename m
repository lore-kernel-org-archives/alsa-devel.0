From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Thu, 10 Feb 2005 20:38:17 -0500
Message-ID: <420C0C89.1010008@voicenet.com>
References: <420270C1.3000706@voicenet.com>	 <1107457227.7256.37.camel@krustophenia.net>	 <4202A72C.3000007@superbug.co.uk> <1107645609.7256.73.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1107645609.7256.73.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Thu, 2005-02-03 at 22:35 +0000, James Courtier-Dutton wrote:
>  
>
>>I think it is unwise to implement a Master volume control for the SBLive 
>>at this time. We had to remove it some time ago, and it can be 
>>implemented in a better way that in the DSP code.
>>
>>    
>>
>
>Really?  This is certainly news to me.  Why did you remove it?  What's
>this "better way" you speak of?  And what's wrong with doing it in the
>DSP?
>
>I wish you had said something sooner.  Users have been complaining
>vociferously about this as long as I have been involved with ALSA (not
>as long as some people, but long enough ;-).
>
>Personally I never thought this was a big deal.  I don't use the Audigy
>master volume anyway, I just adjust the volume inside the app.  It seems
>broken to me for a program like mplayer to grab the master volume
>control anyway.  Shouldn't it just attenuate the PCM samples it's
>generating?
>
>Lee
>
>
>  
>

So was there any sort of decision made regarding this?  Not having a 
Master volume control for the Live! just seems broken, and will surely 
just continue to generate bug reports.

Adam




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
