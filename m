From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: Using specific code for midi/gameport instead of
 generic one.
Date: Mon, 07 Feb 2005 13:19:56 +0100
Message-ID: <42075CEC.6080101@free.fr>
References: <Pine.HPX.4.33n.0502071024410.3379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0502071024410.3379-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,

Clemens Ladisch wrote:
> matthieu castet wrote:
> 
>>what's the advantage of using specific code (via82xx.c for example) for
>>managing midi/gameport instead of the generic module mpu401 and ns558 ?
> 
> 
> The MPU-401 code in via82xx.c is used only for VT82C686 chips where
> the MIDI port shares an interrupt with the AC'97 controller.
> 
Ok, I haven't see that via is different from the removed midi code from 
intel ac 97, because it is only for VT82C686 and the midi port is on the 
pci device.
Anyway, we should check if the midi device is found by pnp for these 
chips. If it is the case, what happen if mpu401 module is load before 
the via module ?

> There is no reason for the gameport code, except that it would work
> even if PnP happens to be disabled.
> 
ns558 work even if the PnP is disable : it will try to see if there is 
something on the following ports [1]. And 0x200 is the port harcoded in 
the via driver, so it should detect it. But perhaps VIA_FUNC_ENABLE_GAME 
will be missing...

Thanks,

Matthieu

[1]
static int ns558_isa_portlist[] = { 0x201, 0x200, 0x202, 0x203, 0x204, 
0x205, 0x207, 0x209,
                                     0x20b, 0x20c, 0x20e, 0x20f, 0x211, 
0x219, 0x101, 0 };



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
