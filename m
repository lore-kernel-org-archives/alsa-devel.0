From: David Smoot <davidsmoot@gmail.com>
Subject: Setting up Alsa by hand on an embedded system
Date: Wed, 21 Dec 2005 19:36:06 -0600
Message-ID: <b15982770512211736m71edba7eyc4885b0c3cd6bd93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9936_10775566.1135215366309"
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

------=_Part_9936_10775566.1135215366309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

OK, I tried this question about a month ago but I did not make it clear I
think.

I need to add the ability to record and playback audio on the embedded linu=
x
platform my company uses.  Being embedded, I do not have a full Linux
distribution.  I have to set up ALSA by hand.  I can't simply untar the als=
a
package and do ./configure followed by make.

Here's what I have done so far:
Rebuilt the kernel to have support for alsa and my chipset (an Intel ICH5
that uses the AC97 codec).
added the /dev/snd/ device nodes (I skipped the midi nodes because I do not
need them
copied libasound.so.2.0.0. from my host development box to the lib path on
my embedded box.  I added all the symlinks pointing to this library.

So I started by compiling some of the simple test programs, specifically th=
e
ones from the LinuxJournal article on ALSA (
http://www.linuxjournal.com/article/6735).  The 4 sample programs run just
fine on my host system.  On my embedded system the command to open the PCM
device fails with:
ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default
unable to open pcm device: No such file or directory

So I changed device name in the code from "default" to "plug:0,0" and it
still fails with the same message (but reads "plug:0,0" instead of default)=
.

So what am I doing wrong?  Do I need a configuration file somewhere?  Do I
need to use a different argument for the PCM open?  Any suggestions?
David

------=_Part_9936_10775566.1135215366309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

OK, I tried this question about a month ago but I did not make it clear I t=
hink.<br><br>I need to add the ability to record and playback audio on the =
embedded linux platform my company uses.&nbsp; Being embedded, I do not hav=
e a full Linux distribution.&nbsp; I have to set up ALSA by hand.&nbsp; I c=
an't simply untar the alsa package and do ./configure followed by make.
<br><br>Here's what I have done so far:<br>Rebuilt the kernel to have suppo=
rt for alsa and my chipset (an Intel ICH5 that uses the AC97 codec).<br>add=
ed the /dev/snd/ device nodes (I skipped the midi nodes because I do not ne=
ed them
<br>copied libasound.so.2.0.0. from my host development box to the lib path=
 on my embedded box.&nbsp; I added all the symlinks pointing to this librar=
y.<br><br>So I started by compiling some of the simple test programs, speci=
fically the ones from the LinuxJournal article on ALSA (
<a href=3D"http://www.linuxjournal.com/article/6735">http://www.linuxjourna=
l.com/article/6735</a>).&nbsp; The 4 sample programs run just fine on my ho=
st system.&nbsp; On my embedded system the command to open the PCM device f=
ails with:
<br>ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default<br>unab=
le to open pcm device: No such file or directory<br><br>So I changed device=
 name in the code from &quot;default&quot; to &quot;plug:0,0&quot; and it s=
till fails with the same message (but reads &quot;plug:0,0&quot; instead of=
 default).
<br><br>So what am I doing wrong?&nbsp; Do I need a configuration file some=
where?&nbsp; Do I need to use a different argument for the PCM open?&nbsp; =
Any suggestions?<br>David<br><br>

------=_Part_9936_10775566.1135215366309--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
