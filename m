From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:48:56 -0400
Message-ID: <200604042148.57286.dtor_core__7901.89524782381$1144201850$gmane$org@ameritech.net>
References: <44238489.8090402@keyaccess.nl> <20060404210048.GA5694@suse.de> <4432EF58.1060502@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp113.sbc.mail.re2.yahoo.com (smtp113.sbc.mail.re2.yahoo.com [68.142.229.92])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 2F894144
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 03:48:59 +0200 (MEST)
In-Reply-To: <4432EF58.1060502@keyaccess.nl>
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

On Tuesday 04 April 2006 18:12, Rene Herman wrote:
> To Dmitry, I see you saying "probe() failing is driver's problem. The 
> device is still there and should still be presented in sysfs.". No, at 
> least in the case of these platform drivers (or at least these old ISA 
> cards using the platform driver interface), a -ENODEV return from the 
> probe() method would mean the device is _not_ present (or not found at 
> least). NODEV.

Or you could separate device probing code from driver->probe(). BTW I think
that ->probe() is not the best name for that method. It really is supposed
to allocate resources and initialize the device so that it is ready to be
used, not to verify that device is present. The code that created device
shoudl've done that.

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
