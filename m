From: Justin Cormack <justin@street-vision.com>
Subject: RME HDSP9652
Date: 27 Nov 2002 17:21:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038417705.3078.14.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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



I have just got a couple of the new RME Hammerfall HDSP9652 cards, and
find that they are not supported by the snd-hdsp driver yet. The card is
basically the same hardware as the other hdsp cards but with the io
integrated on the card.

I would guess that it will need a different firmware and another type in
HDSP_Type, plus the channel info.  Does anyone know how to get the
formware from RME (who to contact)?

I will happily test any patches, or given the formware could prbbaly fix
it...

Justin




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
