From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB audio kernel panic
Date: Mon, 24 May 2004 11:23:42 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B15CAE.1000108@boosthardware.com>
References: <Pine.HPX.4.33n.0405210935120.1699-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Patrick Shirkey wrote:
> 
>>>>Using the latest usb-audio code from cvs I get a kernel panic when
>>>>loading the drivers.
>>>>
>>>>I'm running kernel-2.2.21 with gcc-2.95.4
>>>
>>Unable to handle kernel paging request at virtual address 28302e63
>>EIP:    0010:[<e08eafc0>]    Tainted: PF
>>
>>e08e7060 __insmod_snd-usb-audio_S.text_L29104   [snd-usb-audio]
>>e08eb02c snd_hack_usb_set_interface     [snd-usb-audio]
> 
> 
> The 2.6.5-rc2 kernel introduced some API changes to work around
> devices with broken descriptors.  The resulting changes in the ALSA
> code broke ALSA's workaround for the same problem.
> 
> The fix below is now in CVS.
>

Tested and working.

Thanks.

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
