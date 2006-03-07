From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Mix two mono streams into one stereo.
Date: Tue, 07 Mar 2006 13:18:15 +0000
Message-ID: <1141737495.6054.6.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1141734013-18730-180"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1141734013-18730-180
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I need some help with this. I have written a VoIP application which
captures audio from a microphone input, and plays audio coming through
the network to de audio output.

This application is intended to run on a system with a sound-card that
has only one stereo output, and two different audio streams have to be
played both at the same time through this stereo output. So I need to
mix both mono streams into one stereo stream using ALSA Api.

How is this possible?

Juan Zapatero.


______________________
Este mensaje, y en su caso, cualquier fichero anexo al mismo,
 puede contener informacion clasificada por su emisor como confidencial
 en el marco de su Sistema de Gestion de Seguridad de la 
Informacion siendo para uso exclusivo del destinatario, quedando 
prohibida su divulgacion copia o distribucion a terceros sin la 
autorizacion expresa del remitente. Si Vd. ha recibido este mensaje 
 erroneamente, se ruega lo notifique al remitente y proceda a su borrado. 
Gracias por su colaboracion.
______________________
This message including any attachments may contain confidential 
information, according to our Information Security Management System,
 and intended solely for a specific individual to whom they are addressed.
 Any unauthorised copy, disclosure or distribution of this message
 is strictly forbidden. If you have received this transmission in error,
 please notify the sender immediately and delete it.
______________________

------------=_1141734013-18730-180--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
