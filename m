From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] New snd-audigyls driver available.
Date: Sat, 04 Dec 2004 12:38:39 +0000
Message-ID: <41B1AFCF.5040301@superbug.co.uk>
References: <41AF9A47.3060706@superbug.co.uk>	<s5hk6rzzk5i.wl@alsa2.suse.de>	<41B0BC11.5090106@superbug.co.uk>	<s5h4qj32ln6.wl@alsa2.suse.de>	<41B0CA3C.8070606@superbug.co.uk> <s5hzn0v1441.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 759EB32D
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2004 13:38:44 +0100 (MET)
In-Reply-To: <s5hzn0v1441.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>>
>>>Shall I replace the struct/function names from audigyls to ca0106,
>>>too?  Or, would you like to keep audigyls there?
>>>
>>>
>>>Takashi
>>>
>>
>>Ah! Good question. I think for the sake of consistancy, replacing those 
>>would also be a good idea.
>>Do you want me to do that, or would it be easier if you do it.
> 
> 
> Could you do that?  I can't test the changed driver here.
> 
> 
> Takashi
> 
> 

Done, download the new ca0106 driver from:
http://www.alsa-project.org/~james/alsa-driver/ca0106/

The install.txt explains how to integrate it into the alsa-driver CVS.

The CA0106.conf will replace the AudigyLS.conf


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
