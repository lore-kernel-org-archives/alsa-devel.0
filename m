From: David Smoot <davidsmoot@gmail.com>
Subject: Setting up Alsa by hand on an embedded system round 2
Date: Wed, 28 Dec 2005 16:05:12 -0600
Message-ID: <b15982770512281405o2d769542s7fbeeb3f3e7030e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5905_18168902.1135807512907"
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

------=_Part_5905_18168902.1135807512907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks to the help of the list I've made a lot of progress.  I'm getting a
new error message now when I attempt any capture or playback:
ALSA lib timer_hw.c:269:(snd_timer_hw_open) extended read is not supported
(SNDRV_TIMER_IOCTL_TREAD)

I've got the timer device created (/dev/snd/timer, owner root, group audio,
permissions 666, character device with major of 116 and minor 33).  I'm
trying to find info from the API docs on alsa-project.org but no luck so
far.

I see in /usr/share/alsa/alsa.conf it sets some default timer values:
defaults.timer.class 2
defaults.timer.sclass 0
defaults.timer.card 0
defaults.timer.device 0
defaults.timer.subdevice 0

But I have no idea what these mean or where they are documented.  Can
someone point me to an expanation of the alsa.conf values?
David

------=_Part_5905_18168902.1135807512907
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks to the help of the list I've made a lot of progress.&nbsp; I'm getti=
ng a new error message now when I attempt any capture or playback:<br>ALSA =
lib timer_hw.c:269:(snd_timer_hw_open) extended read is not supported (SNDR=
V_TIMER_IOCTL_TREAD)
<br><br>I've got the timer device created (/dev/snd/timer, owner root, grou=
p audio, permissions 666, character device with major of 116 and minor 33).=
&nbsp; I'm trying to find info from the API docs on <a href=3D"http://alsa-=
project.org">
alsa-project.org</a> but no luck so far.<br><br>I see in /usr/share/alsa/al=
sa.conf it sets some default timer values:<br>defaults.timer.class 2<br>def=
aults.timer.sclass 0<br>defaults.timer.card 0<br>defaults.timer.device 0
<br>defaults.timer.subdevice 0<br><br>But I have no idea what these mean or=
 where they are documented.&nbsp; Can someone point me to an expanation of =
the alsa.conf values?<br>David<br><br>

------=_Part_5905_18168902.1135807512907--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
