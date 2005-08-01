From: "Philip A. Prindeville" <philipp@redfish-solutions.com>
Subject: Re: How to fix "Invalid type for PCM iec958:"?
Date: Mon, 01 Aug 2005 10:18:37 -0600
Message-ID: <42EE4B5D.20202@redfish-solutions.com>
References: <42EBDAC2.9080605@redfish-solutions.com> <s5h64uq9fgd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CF1718F
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 18:18:39 +0200 (MEST)
In-Reply-To: <s5h64uq9fgd.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Sat, 30 Jul 2005 13:53:38 -0600,
>Philip A. Prindeville wrote:
>  
>
>>I've been seeing:
>>
>>alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82 
>>AES2 0x00 AES3 0x02}
>>ALSA lib pcm.c:1851:(snd_pcm_open_conf) Invalid type for PCM 
>>iec958:{CARD 0 AES0 0x02 AES1 0x82 AES2 0x00 AES3 0x02} definition (id: 
>>iec958, value: cards.pcm.iec958)
>>alsa-init: playback open error: Invalid argument
>>
>>
>>And went looking via Google if this is anything obvious.  I saw several
>>other postings about having the same issue, but no clear replies about
>>what causes it, or how to fix it.
>>
>>Should this be a FAQ question?  BTW:  What *is* the fix?
>>    
>>
>
>This depends on the hardware and driver you use.
>Most likely, the SPDIF I/O is not supported or defined in the system
>configuration.
>
>
>Takashi
>  
>

Ok, does anyone have a config file for a VIA8237?  And how does
the "private_string" get set and interpolated into:

                files [
                        {
                                @func concat
                                strings [
                                        { @func datadir }
                                        "/cards/"
                                        { @func private_string }
                                        ".conf"
                                ]
                        }
                ]

-Philip

-Philip



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
