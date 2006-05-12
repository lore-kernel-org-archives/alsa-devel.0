From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Mix audio at different frequencies
Date: Fri, 12 May 2006 12:25:41 +0200
Message-ID: <1147429541.26309.3.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,
I need to mix in playback two different audio streams, one coming from
an ogg player, which is at 44100Hz, and the other one, coming out of a
VoIP application, in this case, at 8000Hz. As I am using the dmix plugin
for mixing, I can't find out how to implement the resampling operations
needed.

Thanks. 


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


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
