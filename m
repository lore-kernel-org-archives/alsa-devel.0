From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
Date: Wed, 05 Apr 2006 20:36:02 +0200
Message-ID: <44340E12.9000202__6226.65274790979$1144264593$gmane$org@keyaccess.nl>
References: <44238489.8090402@keyaccess.nl> <4432EF58.1060502@keyaccess.nl> <44330DFA.4080106@keyaccess.nl> <200604042145.24685.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl [213.51.146.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 38BE8147
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 20:35:49 +0200 (MEST)
In-Reply-To: <200604042145.24685.dtor_core@ameritech.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

Dmitry Torokhov wrote:

>> Well, we could in fact hang an unregister off device->private_data as 
>> per attached example. Wouldn't be _excessively_ ugly. Still sucks 
>> though.
> 
> Plus it broke all the drivers that create platform devices before
> registering drivers or the ones simply not using private data.

No, this was just a suggestion for an ALSA specific workaround. I was 
suggesting ALSA drivers could do this.

Rene.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
