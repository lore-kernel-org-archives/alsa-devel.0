From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: CMI8768 patch, softvol mixer slider
Date: Sat, 19 Feb 2005 19:40:40 +0100
Message-ID: <42178828.2020002@gmx.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D63F@cm-msg-02.cmedia.com.tw>	 <4216EE28.6040702@gmx.de> <1108799809.9005.3.camel@krustophenia.net>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108799809.9005.3.camel@krustophenia.net>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sat, 2005-02-19 at 08:43 +0100, thomas schorpp wrote:
> 
>>hmm, if read the docs right its userspace.
>>
>>how about getting it in the kernel and calling it snd_x_csoftmix ?
> 
> 
> Why?  It works fine in userspace.

surely.

>  The whole point of alsa-lib is to get
> things like software volume control and mixing and sample rate
> conversion that don't need to be in the kernel out of the kernel.

who decides on "need"?

1. sw engineering reuseability:

would you provide a base class without a generalizable feature requiring 
every subclass implementing it? wheres the need for specialization here?

2. the linux audio developers:

"guys, theres no pcm master to access with the alsa driver on some cards 
on the mixers. everone of us must implement it now in our apps, what a 
hell work."

3. audio professionals and simple end user

"guys, i heard therere some great apps like ardour and multi-channel 
realtime audio available on linux at low cost. lets go and save much 
costs, buy this great suse and have fun. ... eh? wheres the pcm slider i 
have with windows gone? they cant even provide that? ... so the other 
apps cant be much. lets boot windows again and forget this suse..."

4. the linux kernel developers?

> 
> Lee
> 
> 

tom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
