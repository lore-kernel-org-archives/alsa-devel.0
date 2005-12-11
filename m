From: Chad Simmons <chad.simmons@gmail.com>
Subject: Question about correct way to code plugin? for ac3 encoding.
Date: Sun, 11 Dec 2005 16:55:03 -0500
Message-ID: <15079f890512111355k211724c5s6d298b13733a156b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4557_22738201.1134338103901"
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

------=_Part_4557_22738201.1134338103901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I was doing a little research today on a project I have been thinking about
implementing. The idea is this I want to write an alsa plugin that takes
multichannel PCM audio in encodes it to AC3 or DTS in realtime and outputs
it as RAW AC3 or DTS on my SPDIF out. This is my plan

Create an alsa plugin that takes mulichannel PCM data and call's ffmpeg(for
AC3 encoding) and passes it directly to the spdif out(as the hwac3 option
does in mplayer).

Would this be the best course of action?

Regards,

Chad Simmons

------=_Part_4557_22738201.1134338103901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,<br>
<br>
I was doing a little research today on a project I have been thinking
about implementing. The idea is this I want to write an alsa plugin
that takes multichannel PCM audio in encodes it to AC3 or DTS in
realtime and outputs it as RAW AC3 or DTS on my SPDIF out. This is my
plan<br>
<br>
Create an alsa plugin that takes mulichannel PCM data and call's
ffmpeg(for AC3 encoding) and passes it directly to the spdif out(as the
hwac3 option does in mplayer).<br>
<br>
Would this be the best course of action?<br>
<br>
Regards,<br>
<br>
Chad Simmons<br>

------=_Part_4557_22738201.1134338103901--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
