From: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: how does alsa keep passing data into driver?
Date: Fri, 14 Oct 2005 12:47:37 +1000
Message-ID: <bf04f99c0510131947m1a5e0a68n631b761818887222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7557_24533627.1129258057622"
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

------=_Part_7557_24533627.1129258057622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am trying to understand how the ALSA pass PCM data to the driver. I have
understand that when the driver starts up, a start trigger event is created
and some PCM data is passed in. After that, how does the subsequent PCM dat=
a
get pass into the driver?

I also realise that a pointer event is generated, but from the docs, the
pointer event is for figuring out the current position.

I am currently working with the S3c2410 cpu and the code s3c2410-iis.c.

Any pointers would be appreciated.
Tehn Yit Chin

------=_Part_7557_24533627.1129258057622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I am trying to understand how the ALSA pass PCM data to the driver. I
have understand that when the driver starts up, a start trigger event
is created and some PCM data is passed in. After that, how does the
subsequent PCM data get pass into the driver?<br>
<br>
I also realise that a pointer event is generated, but from the docs, the po=
inter event is for figuring out the current position.<br>
<br>
I am currently working with the S3c2410 cpu and the code s3c2410-iis.c. <br=
>
<br>
Any pointers would be appreciated.<br>
Tehn Yit Chin<br>


------=_Part_7557_24533627.1129258057622--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
