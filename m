From: Dirk <noisyb@gmx.net>
Subject: Re: 0x10b9:0x5461 not supported?
Date: Thu, 21 Jul 2005 02:22:34 +0200
Message-ID: <42DEEACA.9040901@gmx.net>
References: <Pine.HPX.4.33n.0507201607110.21951-100000@studcom.urz.uni-halle.de>	 <42DE990A.6020702@gmx.net> <1121882838.2970.1.camel@localhost.localdomain>	 <42DE98E9.2010204@gmx.net> <1121888547.2970.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121888547.2970.6.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I checked out alsa-kernel and alsa-driver...

cd alsa-driver
./cvscompile
make install
make install-modules

didn't work (I'd read INSTALL) there were still the old drivers in
/lib/modules/2.6.12.3/.../sound/
so I'd...

ln -sf alsa-driver /usr/src/linux/sound
cd /usr/src/linux
make modules_install
modprobe snd-hda-intel

which didn't work either (snd_hda_intel: unknown symbol...)

...I guess I never done this before

Give me a quick HOWTO and I'll continue..

Dirk

>This looks like old alsa version. Could you try alsa CVS version ?
>
>  
>
It was the alsa stuff included in 2.6.12.3.

>Peter Zubaj
>
>
>On Wed, 2005-07-20 at 20:33 +0200, Dirk wrote:
>  
>
>>Hey!
>>I tried that right now (Kernel 2.6.12.3).
>>
>>sound/pci/hda/hda_intel.c
>>
>>/* PCI IDs */
>>static struct pci_device_id azx_ids[] = {
>>        { 0x8086, 0x2668, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH6 */
>>        { 0x8086, 0x27d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH7 */
>>        { 0x8086, 0x269a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ESB2 */
>>        { 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* test */
>>        { 0, }
>>};
>>
>>
>>and after reloading the module it says
>>
>>ALSA sound/pci/hda/hda_intel.c:442: azx_get_response timeout
>>ALSA sound/pci/hda/hda_intel.c:442: azx_get_response timeout
>>ALSA sound/pci/hda/hda_intel.c:442: azx_get_response timeout
>>ALSA sound/pci/hda/hda_intel.c:442: azx_get_response timeout
>>ALSA sound/pci/hda/hda_intel.c:442: azx_get_response timeout
>>ALSA sound/pci/hda/hda_intel.c:442: azx_get_response timeout
>>[...]
>>
>>and it doesn't look like it will stop anytime soon...
>>
>>Dirk
>>
>>
>>
>>    
>>
>>>Hi,
>>>
>>>Did you try to add this pci id in pci_device_id azx_ids table in file
>>>hda_intel.c ?
>>>
>>>Peter Zubaj
>>>
>>>      
>>>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
