From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Detection of ALC650 rev.E
Date: Tue, 26 Aug 2003 19:00:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4BA046.6060904@superbug.demon.co.uk>
References: <200305210604.IAA04383@www1.pobox.sk> <s5hllx0vdh6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllx0vdh6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 21 May 2003 08:04:44 +0200,
> p z oooo wrote:
> 
>>Hi,
>>
>>I tested code and it doesn't work :-(.
>>When I deleted code to detect ALC650 rev.E, it worked perfect. :-)
>>
>>May be:
>>1) MSI uses ALC650 rev.E and stil uses gpio0 to switch mic power 
>>on/off
>>2) detection code for ALC650 rev.E is wrong
> 
> 
> most likely the latter...
> perhaps chaging GPIO0 won't affect the behavior of rev.E.
> i'll remove it.
> 
> 
> thanks,
> 
> Takashi
> 
> 
How is the ALC650 rev.E detected? I could not see anything in the alc650 
pdf specifications to indicate how to detect the ALC650 rev.E or not.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
