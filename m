From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [Alsa-devel] Re: Audigy SPDIF Output Sample Rate
Date: Fri, 25 Feb 2005 22:44:38 +0000
Message-ID: <421FAA56.90204@superbug.co.uk>
References: <1108880895.6773.50.camel@radium.gaugetheory.org>	 <1109351825.9681.43.camel@krustophenia.net>	 <1109367868.6245.9.camel@cthulhu.rlyeth.net>	 <1109368727.13193.10.camel@krustophenia.net>	 <421FA52F.7050405@superbug.co.uk> <1109370717.13193.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109370717.13193.18.camel@krustophenia.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: The Orqwith Vagrant <theorqwithvagrant@bredband.net>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> 
> 
> OK, that makes things clearer.  So the 96KHz output Vagrant is hearing
> has been internally resampled to 48KHz, but once we have proper P16V
> support it will be "real" 96KHz.
> 
> Do you think we should disable this control until the your P16V patch
> goes in?  There are no real conflicts with the P16V and multichannel
> patches, it looks like it's just a matter of regenerating it.
> 

In my p16v.c code there is the line:

#define P16V_OFFSET 0x03 /* FIXME: The number of the first P16V device. */

So this is obviously not going to work with the multichannel patch, 
because it uses device 3.

The fix is relatively simple, but I will need to implement mixer 
controls as well before my code is ready to commit.
I will get round to is some time, but not this weekend.

James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
