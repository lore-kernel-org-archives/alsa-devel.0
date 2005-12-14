From: laugeo2@free.fr
Subject: Ameter plugin : looping sound
Date: Wed, 14 Dec 2005 23:17:48 +0100
Message-ID: <1134598668.43a09a0cb1add@imp3-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi,
 Ameter  is a metering plugin for Alsa :
http://laugeo.free.fr/ameter.html
 It stopped working since 1.0.10,and also fails with 1.0.11rc1 (was ok wi=
th
1.0.9) :
Playing a sound with aplay (or any other program) cause  a short sound lo=
oping
in audio out ,while  peakmeter displays the real soundfile level .
 It seems that the looping sound is the end of the last played sound .
 I have Mandriva 2005 (2.6.11 standard kernel),  ens1371 sound card.
Somenone else has reported the problem ( I don't know his config) .

Test command:
aplay -D ameter sound.wav -v
It returns no error.

My .asoundrc:

pcm_scope.ameter {
        type ameter
}
pcm_scope_type.ameter {
        lib /usr/local/lib/libameter.so
}
pcm.ameter {
        type meter
        slave.pcm  hw
        scopes.0 ameter
}
pcm.dsp0 ameter

Thanks for any idea !
Laurent Georget


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
