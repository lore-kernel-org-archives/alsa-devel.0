From: Manuel Jander <mjander@embedded.cl>
Subject: Re: Mono to stereo ?
Date: Thu, 27 Mar 2003 23:14:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E83BE0E.4070406@embedded.cl>
References: <E18yVi8-0003Mx-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18yVi8-0003Mx-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Paul Davis wrote:

>>When an application opens a mono substream, the sound has to
>>be sent to one channel only or must the low level driver
>>transparently convert it to stereo ?
>>    
>>
>
>one channel only.
>
>in ALSA, low level drivers do not do any kind of format
>conversion. that is accomplished (if necessary) by code running in
>user-space, typically part of alsa-lib. the low level driver simply
>advertises the capabilities of the hardware, provides ways to use
>those capabilities, and lets the midlevel code and alsa-lib do the rest.
>  
>

...but, if you are doing mono playback, your sound driver has to setup
your soundcard to playback on both channels the same mono channel. The 
Vortex
driver (still not in the main branch) for example splits the mono signal 
on its internal
mixer into 2 identical signals which are feed one into each CODEC channels.

Best Regards

Manuel Jander

>--p
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by:
>The Definitive IT and Networking Event. Be There!
>NetWorld+Interop Las Vegas 2003 -- Register today!
>http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>.
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
