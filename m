From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142
 mobo
Date: Mon, 08 Aug 2005 10:16:41 -0600
Message-ID: <42F78569.5070604@redfish-solutions.com>
References: <42F655E2.5040504@redfish-solutions.com> <20050807192732.GA3079@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 11EEC1D6
	for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2005 18:16:54 +0200 (MEST)
In-Reply-To: <20050807192732.GA3079@procyon.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sergey Vlasov wrote:

>On Sun, Aug 07, 2005 at 12:41:38PM -0600, Philip Prindeville wrote:
>  
>
>>Can we please commit this minor fixes to the tree?  I've been
>>using them and they seem to work fine.
>>
>>Thanks,
>>
>>-Philip
>>
>>    
>>
>
>  
>
>>*** alsa-kernel/pci/via82xx.c.bak	2005-05-27 04:10:18.000000000 -0600
>>--- alsa-kernel/pci/via82xx.c	2005-07-25 20:33:51.000000000 -0600
>>***************
>>*** 2174,2179 ****
>>--- 2174,2180 ----
>>  		{ .vendor = 0x1462, .device = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
>>  		{ .vendor = 0x1462, .device = 0x7023, .action = VIA_DXS_NO_VRA }, /* MSI K8T Neo2-FI */
>>  		{ .vendor = 0x1462, .device = 0x7120, .action = VIA_DXS_ENABLE }, /* MSI KT4V */
>>+ 		{ .vendor = 0x1462, .device = 0x7142, .action = VIA_DXS_ENABLE }, /* MSI K8MM-V */
>>    
>>
>
>Did you try VIA_DXS_SRC instead?  If it works, it gives more
>capabilities (any sample rate - not discrete values, and separate
>sample rates for all 4 DXS channels).
>  
>

Ok.  I've built a new image that has that set (I've also added an entry
for the K8MM-ILSR which is an identical motherboard but missing
video).

How do I add the separate sample rates for the 4 DXS channels, and
how do I test all of this?

Thanks,

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
