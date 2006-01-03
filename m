From: LWATCDR <lwatcdr@gmail.com>
Subject: Simple question.
Date: Tue, 3 Jan 2006 16:42:26 -0500
Message-ID: <8c38cea40601031342s7b3158e2k99de34c50c4fb6ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26824_17245597.1136324546262"
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

------=_Part_26824_17245597.1136324546262
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am just starting to work with Alsa I compiled a test program from one of
the tutorials and I am getting this error message.
Unknown Error 126.
Does anyone know what error 126 is?
I am using "plughw:0,0" as the device name.
and this is the segment of code that generates the error.

for (i =3D 0; i < 10; ++i) {
if ((err =3D snd_pcm_writei (playback_handle, buf, 128)) !=3D 128) {
    fprintf (stderr, "write to audio interface failed (%s)\n", snd_strerror
(err));
    exit (1);
    }
}


I am running Suse 9.3+kde 3.5

I hope this is the correct list to ask this.

------=_Part_26824_17245597.1136324546262
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am just starting to work with Alsa I compiled a test program from one of =
the tutorials and I am getting this error message.<br>Unknown Error 126.<br=
>Does anyone know what error 126 is?<br>I am using &quot;plughw:0,0&quot; a=
s the device name.
<br>and this is the segment of code that generates the error.<br><br>for (i=
 =3D 0; i &lt; 10; ++i) {<br>if ((err =3D snd_pcm_writei (playback_handle, =
buf, 128)) !=3D 128) {<br>&nbsp;&nbsp;&nbsp; fprintf (stderr, &quot;write t=
o audio interface failed (%s)\n&quot;, snd_strerror (err));
<br>&nbsp;&nbsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; }<br>}<br><br><br>I =
am running Suse 9.3+kde 3.5<br><br>I hope this is the correct list to ask t=
his.<br>

------=_Part_26824_17245597.1136324546262--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
