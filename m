From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: Re: Mono to stereo ?
Date: Fri, 28 Mar 2003 11:21:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E847670.8070006@rogers.com>
References: <E18yVi8-0003Mx-00@sc8-sf-list1.sourceforge.net>	<3E83BE0E.4070406@embedded.cl> <s5h65q3olkj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65q3olkj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Manuel Jander <mjander@embedded.cl>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 27 Mar 2003 23:14:22 -0400,
>Manuel Jander wrote:
>  
>
>>...but, if you are doing mono playback, your sound driver has to setup
>>your soundcard to playback on both channels the same mono channel. The 
>>Vortex
>>driver (still not in the main branch) for example splits the mono signal 
>>on its internal
>>mixer into 2 identical signals which are feed one into each CODEC channels.
>>    
>>
>
>no, please don't do that.
>in the ALSA, instead of the lowlevel driver, alsa-lib (and
>oss-emulation module) will do this job.
>
In this case the card (not driver) is spliting the mono signal and 
sending it to both right and left channels of the codec. Thus 
channels_min should still be 1 because the card does actually support a 
single channel

>the driver is supposed to inform exactly what it supports.
>in this case, both channels_min and channels_max will be 2.
>the difference of configuration will be absorbed by the plug-in of 
>alsa-lib and oss-emulation module.
>  
>

-Jeff




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
