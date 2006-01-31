From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: [PATCH] ALS300(+)
Date: Tue, 31 Jan 2006 12:08:44 -0500
Message-ID: <20060131170846.859D21CE306@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, sorry for the slow response.

> BTW, could you try the patch below whether the suspend/resume works?
> If your machine isn't a laptop, try the following:
>=20
> 	# echo 3 > /sys/device/pci*/$YOUR-ALS300/power/state
> (it's a pseudo suspend on the given device)
>=20
> 	# echo 0 > /sys/device/pci*/$YOUR-ALS300/power/state
> (it's a pseudo resume on the given device)

Your pm patch, for me at least, seems to result in the same behaviour that =
Giuliano Pochini has described regarding the echo driver. The pm callbacks =
never seem to get called. Maybe i'm doing something wrong, i've never touch=
ed power management before.
Reading the power/state file always gives a value of 0. I don't know if thi=
s is correct behaviour.

Anything i should do to make sure power management is all set up properly?

Ash Willis

--=20
___________________________________________________
Play 100s of games for FREE! http://games.mail.com/



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
