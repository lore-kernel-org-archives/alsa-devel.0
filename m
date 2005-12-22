From: David Smoot <davidsmoot@gmail.com>
Subject: Re: Setting up Alsa by hand on an embedded system
Date: Thu, 22 Dec 2005 09:53:41 -0600
Message-ID: <b15982770512220753x72c28d9dxa60312f872bf1766@mail.gmail.com>
References: <b15982770512211736m71edba7eyc4885b0c3cd6bd93@mail.gmail.com>
	 <20051222152613.GA6625@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2182_528755.1135266821132"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051222152613.GA6625@stud.ntnu.no>
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

------=_Part_2182_528755.1135266821132
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I don't the dir variable is the issue because I am not getting segfaults.
The code compiles and works on my "host machine" (full debian box) but does
not on my embedded.

It appears that combining the two suggestions from Clements and Steve have
gotten me further.  It appears that the file /usr/share/alsa.conf loads the
default configuration and also loads the file in /etc/asound.conf.  I get a
different error now, I think I need to tweak the files in /usr/share/alsa t=
o
match the correct chipset.

Does the alsa configuration environment require python?  My embedded system
does not have python.  I'm sure I will have to hack it in someday but it is
not there yet.

I've gotten further but a few more errors but I think you all have gotten m=
e
on the correct track.  Thank you.

David

------=_Part_2182_528755.1135266821132
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I don't the dir variable is the issue because I am not getting segfaults.&n=
bsp; The code compiles and works on my &quot;host machine&quot; (full debia=
n box) but does not on my embedded.<br><br>It appears that combining the tw=
o suggestions from Clements and Steve have gotten me further.&nbsp; It appe=
ars that the file /usr/share/alsa.conf loads the default configuration and =
also loads the file in /etc/asound.conf.&nbsp; I get a different error now,=
 I think I need to tweak the files in /usr/share/alsa to match the correct =
chipset.
<br><br>Does the alsa configuration environment require python?&nbsp; My em=
bedded system does not have python.&nbsp; I'm sure I will have to hack it i=
n someday but it is not there yet.<br><br>I've gotten further but a few mor=
e errors but I think you all have gotten me on the correct track.&nbsp; Tha=
nk you.
<br><br>David<br>

------=_Part_2182_528755.1135266821132--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
