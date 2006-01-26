From: "Stefano Papini" <s.papini@tbridge.it>
Subject: Re: snd-usb-audio
Date: Thu, 26 Jan 2006 09:53:47 +0100
Message-ID: <43D88E1B.8030006@tbridge.it>
References: <43D60350.5090003@tbridge.it> <1138120858.43d6589a3c429@webmail.uni-halle.de> <43D730B4.3030907@tbridge.it> <20060125174317.GA26956@ifiu25.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <20060125174317.GA26956@ifiu25.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ciao Clemens,
first of all thanks a lot for your kind feedback, I think you do have=20
more important things than following an alsa newbie...

Anyway, yesterday late evening I tried with the asound.conf which gave=20
me a lot of trouble (and the U24 keeps on muting).

Clemens Ladisch wrote:

> Stefano Papini wrote:
>
>> Perhaps I did something wrong in /etc/asound.conf (I follwed =
PlanetCCRMA
>> hints on writing one)???
>
>
> You shouldn't need to write such a file.


I'll try without it.

>> iManufacturer 1 Ego Systems Inc.
>> iProduct 2 U24
>
>
> I guess this is your "Swissonic Studio D MkII"?
>
Exactly.

>>Intel 810 + AC97 Audio, version 1.01, 10:51:24 Jan 24 2006
>>
>
>This is a message from the OSS driver for your internal sound card.
>Better don't use OSS and ALSA drivers at the same time.
>
>
I see, but how can I disable it? I have already added snd-intel8x0 in=20
/etc/hotplug/

>>aplay: main:544: audio open error: Broken pipe
>>ALSA usbaudio.c:821: cannot submit datapipe for urb 3, err =3D -28
>>
>
>Disable USB bandwidth checking (CONFIG_USB_BANDWIDTH) in the kernel
>configuration.
>
>
I'll cook a kernel and will report you. Many thanks!

Stefano

>
>HTH
>Clemens
>
>


ATTENZIONE: Il contenuto di questo messaggio e' rivolto unicamente alle =
persone cui e' indirizzato e puo' contenere informazioni la cui =
riservatezza e' tutelata legalmente. Ne sono vietati la riproduzione, la =
diffusione e l'uso in mancanza di autorizzazione del destinatario. Se =
l'avete ricevuto per errore vogliate eliminare il messaggio in modo =
permanente e darcene cortesemente notizia. I messaggi e gli allegati =
sono analizzati automaticamente per ricercare tutti i virus conosciuti. =
Se questo messaggio contiene allegati protetti da password, i files NON =
saranno analizzati per ricercare i virus dal dominio di posta. =
Analizzate sempre gli allegati prima di aprirli.

ATTENTION: This message and any files transmitted with it is intended =
for the adressee only and may contain information that is confidential =
or privileged. Unauthorised use is strictly prohibited and may be =
unlawful. If you are not the addressee, you should not read, copy, =
disclose or otherwise use this  message, except  for the purpose of =
delivery to the addressee. In case of accidental receipt, please inform =
us. Messages and attachments are scanned for all viruses known. If this =
message contains password-protected attachments, the files have NOT been =
scanned for viruses by the mail domain. Always scan attachments before =
opening them.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
