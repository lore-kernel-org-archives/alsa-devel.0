From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Fri, 05 Jul 2002 17:34:39 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D255A1F.6090505@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de> <3D247676.8090309@boosthardware.com> <200207042059.10950.thorsten.haas@gmx.de> <200207050856.26032.thorsten.haas@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thorsten Haas <thorsten.haas@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thorsten Haas wrote:
>>>I'm not sure about the sound quality it is definitely better. I will see
>>>if I can generate a test tone to use instead of actual music.
>>
> 
> I checked out cvs this morning and compiled. I grabbed my function generator 
> and fed my quattro usb with some signal; 400Hz, 0,7V peak-to-peak.
> 
> It's working finely now. (no more peaks)
> 
> I did the same thing some days before. ( Whoever is interested in the results 
> and the output of the oscilloscope: http://www.thorstenhaas.de/alsa.php)
> 
>

That looks much better.

We still face the problem of accessing all 4 channels at once. AFAICT in 
the .asoundrc file the multi interface option does not have the ability 
to seperately access the channels in non sequential order. Therefore we 
are currently unable to access all the channels on the card because pcm0 
and pcm1 point to the same physical channels input 1 and input 2.

We need to either reorganise the pcm devices for the card or make it 
possible to secify channels in non sequential order using the multi 
interface option in a .asoundrc.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
