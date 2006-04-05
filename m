From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:45:24 -0400
Message-ID: <200604042145.24685.dtor_core@ameritech.net>
References: <44238489.8090402@keyaccess.nl> <4432EF58.1060502@keyaccess.nl> <44330DFA.4080106@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp110.sbc.mail.re2.yahoo.com (smtp110.sbc.mail.re2.yahoo.com [68.142.229.95])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EE21B121
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 03:45:26 +0200 (MEST)
In-Reply-To: <44330DFA.4080106@keyaccess.nl>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 04 April 2006 20:23, Rene Herman wrote:
> Rene Herman wrote:
> 
> > As said before, if the behaviour makes sense for other busses, maybe 
> > propagating errors up should be dependent on a flags value somewhere 
> > that a platform-driver sets?
> > 
> > If platform_device_register_simple() never returns an IS_ERR() when the 
> > device is not found that means it's not a useful interface for hardware 
> > that needs to be probed for at the very least. ALSA would need to do 
> > something like, just before returning a succesfull return from the 
> > probe() method, set a global flag that the platform_device that is about 
> > to be registered is actually representing something, and freeing all 
> > platform_devices for which the flag is _not_ set again after this.
> > 
> > Which ofcourse means this is not at all useful. It's just working around 
> > the driver model then...
> 
> Well, we could in fact hang an unregister off device->private_data as 
> per attached example. Wouldn't be _excessively_ ugly. Still sucks 
> though.

Plus it broke all the drivers that create platform devices before
registering drivers or the ones simply not using private data. Given
that some arches have a means to separate device creation from driver
probing (see pcspkr on PPC for exaple) I don;t think this is acceptable.

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
