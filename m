From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: 24bit hdsp
Date: Wed, 28 May 2003 17:12:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19L88r-0001gH-00@sc8-sf-list1.sourceforge.net>
References: <1054149608.429.41.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "28 May 2003 15:20:08 EDT."
             <1054149608.429.41.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>what would it take to support 24bit audio in the hdsp driver? Would it
>take away from the number of available channels? I'd like to use an
>Alesis AI-3 (mostly due to cost) with my multiface, but I'd like to be
>able to utilize all 18 channels the multiface provides. Is there any way
>I can help?

the driver already supports 24 bit audio. if you use the hw layer, it
must match the hw's definition of 24 bit: 24 bits packed in the upper
bits of a 32 bit word. if you use the plughw layer, you can probably
get "true" 24 bit audio (i doubt if this code path has been explored
much). 

i'm not really sure what you're asking.

--p



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
