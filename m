From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] emu10k1: fix P16V breakage for	non	Audigy2
 cards
Date: Fri, 18 Mar 2005 19:52:58 +0000
Message-ID: <423B319A.8080306@superbug.co.uk>
References: <1110950511.19984.9.camel@mindpipe>	 <1110950832.19984.13.camel@mindpipe>  <4238A516.7070802@superbug.co.uk> <1111074813.23171.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111074813.23171.11.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2005-03-16 at 21:28 +0000, James Courtier-Dutton wrote:
> 
>>Thank you for fixing the bug.
>>The "unhandled interrupt" should be commented out. It is used for 
>>reverse engineering certain features.
>>
> 
> 
> OK, updated patch attached.
> 
> Please apply to CVS ASAP, this is a bad bug!
> 
> Lee
> 
> 

I think that this "bad bug" will also effect Audigy 1 cards.
Does that new if statement in the irq handler correctly exclude Audigy 1 
cards ?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
