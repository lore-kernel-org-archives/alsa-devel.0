From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Re: Writing a Full-Duplex
	(capture/playback)	application.
Date: Fri, 23 Dec 2005 12:55:46 +0100
Message-ID: <1135338946.22198.9.camel@jazc.fedora>
References: <1135243534.13713.7.camel@jazc.fedora>
	 <43AAE5A4.60902@pianodisc.com> <1135330750.22198.4.camel@jazc.fedora>
	 <43ABD837.80601@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1135338944-1023-318"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43ABD837.80601@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1135338944-1023-318
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The problem about sample rate is that I need the captured audio to be as
much compressed as possible so that I can get it trough a GPRS link.
That's why I use 8000Hz, 16bit, and I would like to capture in Mono,
because there is no sense in capturing stereo channels with a mono
microphone.

> When doing full duplex, do not open the device as full duplex, open the 
> device twice. Once for playback and once for capture. The reason for 
> this is that sound cards often have different buffer sizes for capture 
> and playback, and so separating them gives you more control over buffer 
> and period sizes.
> For playback use device name "plug:front", for capture you can use the 
> same "plug:front". The important bit it the "plug", as it will do sample 
> rate and sample format conversion for you.
> For low latency application like voice, it is actually better to sample 
> at high frequencies, e.g. 48000Hz. You then do the sample rate 
> conversion in your application. This way, not only is the sample rate 
> conversion much higher quality than alsa-lib can probably do, it can 
> also be optimised for your application. e.g. VoIP usually uses 20ms of 
> voice per packet. You can create a very efficient block sample rate 
> converter when taking all 20ms into account.
> There is also an option in the api to force the "plug" layer to do 
> sample format conversion, but not sample rate conversion, thus ensuring 
> that alsa-lib does not do any sample rate conversion, leaving your 
> application to do it.
> 
> James



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

------------=_1135338944-1023-318--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
