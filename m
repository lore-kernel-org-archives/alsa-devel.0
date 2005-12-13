From: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: power management in ALSA
Date: Wed, 14 Dec 2005 10:50:05 +1100
Message-ID: <bf04f99c0512131550r13b4197fx97f03e4a0c2672d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_815_32638535.1134517805939"
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

------=_Part_815_32638535.1134517805939
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I am trying to put power management awareness into a driver that I wrote,
but I am having a little trouble understanding which model to use.

Looking at the other drivers, I noticed that the suspend/resume callbacks
can be registered via snd_card_set_pm_callback(). The power management is
then handled via pm.c and friends.

The other way is to initialise the suspend/resume callbacks via the linux
device driver model like the following, and then registered via
driver_register(). I think that the power management is then handled by
sysfs.

static struct device_driver codec_driver =3D {
        .name =3D "codec",
        .bus =3D &platform_bus_type,
        .probe =3D codec_probe,
        .remove =3D codec_remove,
        .suspend =3D codec_suspend,
        .resume =3D codec_resume
};

Any suggestions on which is a better/correct method is welcome.

many thanks,
tyc

------=_Part_815_32638535.1134517805939
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br><br>I am trying to put power management awareness into a driver =
that I wrote, but I am having a little trouble understanding which model to=
 use. <br><br>Looking at the other drivers, I noticed that the suspend/resu=
me callbacks can be registered via snd_card_set_pm_callback(). The power ma=
nagement is then handled via=20
pm.c and friends.<br><br>The other way is to initialise the suspend/resume =
callbacks via the linux device driver model like the following, and then re=
gistered via driver_register(). I think that the power management is then h=
andled by sysfs.
<br><br>static struct device_driver codec_driver =3D {<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;codec&quot;,<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; .bus =3D &amp;platform_bus_type,<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .probe =3D codec_probe,<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .remove =3D codec_remove,<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .suspend =3D codec_suspend,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D codec_resume<br>=
};<br><br>Any suggestions on which is a better/correct method is welcome.<b=
r><br>many thanks,<br>tyc<br>

------=_Part_815_32638535.1134517805939--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
