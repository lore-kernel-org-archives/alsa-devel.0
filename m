From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: mpu401_pnp
Date: Mon, 07 Feb 2005 13:10:19 +0100
Message-ID: <42075AAB.8060608@free.fr>
References: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from postfix4-1.free.fr (postfix4-1.free.fr [213.228.0.62])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F94621A
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 13:10:26 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
Clemens Ladisch wrote:
> castet.matthieu@free.fr wrote:
> 
>>I send you a mpu401 modules that support pnpbios.
> 
> 
> Applied (merged with mpu401.c), thanks.
> 
> (I didn't read your mail from Friday until I had written the patch. :)
Ok, I found a bug in your patch : when you call pnp_register_driver, you 
should check that it is >= 0. If not you shouldn't call 
pnp_unregister_driver.


Matthieu


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
