From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Re: Writing a Full-Duplex (capture/playback)
	application.
Date: Fri, 23 Dec 2005 10:39:10 +0100
Message-ID: <1135330750.22198.4.camel@jazc.fedora>
References: <1135243534.13713.7.camel@jazc.fedora>
	 <43AAE5A4.60902@pianodisc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1135330750-1023-108"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43AAE5A4.60902@pianodisc.com>
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

------------=_1135330750-1023-108
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've solved the problem concerning encapsulation into wave format,
thanks to Steve deRosier, but I still have another problem. How can I
configure hw:0,0 device to capture and play audio in Mono mode (only 1
channel).
I've tried to specify 1 channel with
snd_pcm_hw_params_set_channels(captura, cparams, 1), but I get an
'Unable to set channels' error.

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

------------=_1135330750-1023-108--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
