From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Writing a Full-Duplex (capture/playback) application.
Date: Thu, 22 Dec 2005 10:25:33 +0100
Message-ID: <1135243534.13713.7.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1135243534-26272-274"
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

------------=_1135243534-26272-274
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
First of all, I'm going to explain what am I trying to do, so that best
help can be provided.
My final objective is to write a VoIP app to be used over a GPRS
network, but so far, I'm only taking care about audio. I need to capture
audio, compress it with Speex, and then, in the other end, decompress it
and play it. I have written an app based on ALSA api tutorials that
records audio into a raw file, but then, this raw file is not recognized
by Speex encoder, so that I need the file recorded into wav format.
Can anyone help me on how to capture audio into wav format?
Thanks a lot.


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

------------=_1135243534-26272-274--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
