From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Multiple sound cards
Date: Thu, 26 Aug 2004 20:57:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408270057.i7R0v7lp029306@localhost.localdomain>
References: <200408261825.20230.georgesak@spymac.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 26 Aug 2004 18:25:20 EDT."
             <200408261825.20230.georgesak@spymac.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: georgesak@spymac.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi everyone, I'm new to this mailing list.
>I have a question, I couldn't find the answer on google. Imagine I have 2 
>sound cards both configured under alsa. Is there a way to switch the default 
>one through software (is there like an API call that does that) ?

its hard to define the default one. but to take the simplest possible
case, which is an application that opens a PCM (audio) device called
"default", the definition is in /usr/share/alsa/alsa.conf:

   defaults.ctl.card 0
   defaults.pcm.card 0
   defaults.pcm.device 0
   defaults.pcm.subdevice -1

change the zeroes to ones, and "default" will refer to the second
card.

to go further, ask further questions.

--p


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
