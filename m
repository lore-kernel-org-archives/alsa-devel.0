From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Fri, 11 Feb 2005 19:01:38 +0000
Message-ID: <420D0112.2050509@superbug.co.uk>
References: <420270C1.3000706@voicenet.com>	 <1107457227.7256.37.camel@krustophenia.net>	 <4202A72C.3000007@superbug.co.uk> <1108141670.20188.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108141670.20188.4.camel@krustophenia.net>
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
Cc: Adam K Kirchhoff <adamk@voicenet.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Thu, 2005-02-03 at 22:35 +0000, James Courtier-Dutton wrote:
> 
>>I think it is unwise to implement a Master volume control for the SBLive 
>>at this time. We had to remove it some time ago, and it can be 
>>implemented in a better way that in the DSP code.
>>
> 
> 
> James, can you please elaborate on this a bit?  If you have a better way
> then I don't want to waste time doing it in the DSP.
> 
> Lee
> 

This should instead be supported in the alsa-lib mixer abstraction 
layer, that unfortunately, has not been completed yet.
Then, the DSP would have 3 stereo controls for front, rear, center/lfe 
and the mixer lisp config would add a "virtual" Master control, that 
would present a single "Master" control to the user application, but 
alsa-lib would convert that to control messages to all 3 stereo controls.

I think your time would be better spent completing the mixer abstraction 
layer that other alsa developers have already started.

Another point, I personally did not remove the Master control, but it 
disappeared due to lack of SB Live DSP GPR registers.

James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
