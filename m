From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME HDSP9652
Date: Thu, 28 Nov 2002 08:42:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18HOse-0007Vf-00@sc8-sf-list1.sourceforge.net>
References: <1038417705.3078.14.camel@lotte>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "27 Nov 2002 17:21:40 GMT."
             <1038417705.3078.14.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have just got a couple of the new RME Hammerfall HDSP9652 cards, and
>find that they are not supported by the snd-hdsp driver yet. The card is
>basically the same hardware as the other hdsp cards but with the io
>integrated on the card.
>
>I would guess that it will need a different firmware and another type in
>HDSP_Type, plus the channel info.  Does anyone know how to get the
>formware from RME (who to contact)?

all i need is the PCI ID from you. i've already spoken to RME about
the card, and the claim is that it will with the existing h-dsp
driver. the only thing that won't work are the RMS meters. the
existing driver, however, doesn't recognize the PCI ID and so it
doesn't work.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
