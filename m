From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 13:56:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19PnHF-0006fS-00@sc8-sf-list1.sourceforge.net>
References: <3EE61792.2070702@iis.fhg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 10 Jun 2003 19:38:26 +0200."
             <3EE61792.2070702@iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Allamanche <alm@iis.fhg.de>
Cc: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Is this is a design flaw? How to tell the input frequency? Need some 
>additionnal hardware?

the ALSA h/w parameters are things set by an application (and
perhaps later read by the same or a different application). 

what ALSA supports (and the hdsp driver in particular; the digi9652 is
not so good here) is the notion of defining the clock source. if the
clock source is internal, then some h/w (i think this applies to the
digi9652) can't tell you the external rate for the ADAT signal. if the
clock source is external, then you can't set the rate from an
application. of course, you might want to know what it is. in which
case, you have to read the relevant control, which is called "External
Rate" on the hdsp series. unfortunately, an equivalent control does
not exist for the digi9652 series, though it would be easy to write (i
would do it if i wasn't so busy with other projects right now).

i think it would have been good for ALSA to have considered this more
early on; as it is, only a few cards support external clocking, and
the drivers for those cards have had to make it up as they were written.

>I checked it again, ADAT is only defined for 44.1/48 kHz. I mixed it up 
>with the Hammerfall specifications in the manual. The supported 
>frequencies ranges from 32 to 96kHz (SPDIF mode?)

as explained, ADAT can be used up to 96kHz but it halves the number of
available channels.


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
