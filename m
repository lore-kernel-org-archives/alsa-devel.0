From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/usb usbaudio.c,1.12,1.13 ...
Date: Fri, 04 Oct 2002 09:49:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9D47ED.10706@ladisch.de>
References: <E17x3I7-0005RW-00@usw-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> Modified Files:
> 	usbaudio.c usbmidi.c usbmixer.c 
> Log Message:
> Fixes for 2.5 USB core

 > (...)
 >

> +#ifndef OLD_USB
> +	return 0;
> +#else
>  	return chip;
> +#endif

 >
 > (...)
 >

> +#ifndef OLD_USB
> +	void *ptr = dev_get_drvdata(&intf->dev);
> +#endif


IMHO a call do dev_set_drvdata(dev, chip) is missing.


Regards
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
