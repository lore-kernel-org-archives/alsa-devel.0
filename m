From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: 96KHz SPDIF output
Date: Fri, 23 Sep 2005 11:17:32 -0600
Message-ID: <433438AC.3040906@redfish-solutions.com>
References: <Pine.HPX.4.33n.0509230853080.28663-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BE0B515A
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 19:17:35 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0509230853080.28663-100000@studcom.urz.uni-halle.de>
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

Clemens Ladisch wrote:

>Philip Prindeville wrote:
>  
>
>>I was reading the datasheet on the VT1617A, that bit 3 (i.e. 0x0008) of
>>register 0x76 (miscellaneous register) controls the SPDIF_96 mode...
>>
>>In this mode, the odd samples (N+1) go to SDATA_OUT1 (instead of
>>SDATA_OUT)... which is supported if bit 1 (0x0002) is set when this
>>register is read back (EN_DRA).
>>
>>And was wondering if it was fairly simple/straightforward to add
>>support for this...
>>    
>>
>
>Good question.  Thank you for volunteering to find out!  ;-)
>
>
>SCNR
>Clemens
>
>  
>

Unfortunately, none of my hardware supports it, or I might.

-Philip



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
