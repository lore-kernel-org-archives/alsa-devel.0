From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Soundcard matrix: removing some M-Audio USB devices
Date: Tue, 02 Mar 2004 14:09:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40441706.4040602@boosthardware.com>
References: <20040229232621.GB10518@fliwatut.scifi> <404276D4.1010208@superbug.demon.co.uk> <20040301001027.GC10518@fliwatut.scifi> <40437B14.7020702@superbug.demon.co.uk>
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
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Frank Barknecht <fbar@footils.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Frank Barknecht wrote:
> 
>> Hallo,
>> James Courtier-Dutton hat gesagt: // James Courtier-Dutton wrote:
>>
>>
>>> You will be lucky to find any sound card complying with the USB Audio 
>>> spec, as the spec is written so badly.
>>
>>
>>
>> This is the USB spec I'm referring, not the USB AUDIO spec. Those
>> M-Audio devices aren't even recognized as being USB devices by the
>> kernel.
>>
>> ciao
> 
> 
> So "lsusb" gives no output for the device?
> I have seen some usb devices that connect, and then for some reason the 
> kernel does not like them, and disconnects them before you have a chance 
> to see them in lsusb.
> 
> Which part of the USB spec do they break ?
> 

They have inappropriate altsettings. There is a patch which Sampo 
Savolainen just released but it probably won't be accepted to the Kernel.

I'll make a mention of it.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
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
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
