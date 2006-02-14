From: Luca Piccioni <luca.piccioni@gmail.com>
Subject: Re: IEC958 plugin and Rate plugin programming
Date: Tue, 14 Feb 2006 11:22:51 +0100
Message-ID: <43F1AF7B.1020909@gmail.com>
References: <43EDAE9C.7060808@gmail.com> <20060213081740.GB8896@ifiu25.informatik.uni-halle.de> <43F0A236.8050604@gmail.com> <20060213160231.GG9177@ifiu25.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060213160231.GG9177@ifiu25.informatik.uni-halle.de>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- -----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clemens Ladisch wrote:

> What is the output of "iecset"?

$iecset
Mode: consumer
Data: audio
Rate: 48000 Hz
Copyright: permitted
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

$iecset -x
AES0=0x04,AES1=0x82,AES2=0x00,AES3=0x02


I don't understand many thing... first "professional" and "consumer"
modes: how they influence my applications?
What are that parameters AES*? I've seen some sources setting to some
constant, but I have no pointers
to a good documentation (even using developers point of view) :-(

I don't believe in a ALSA driver/library bug, but in a my
mis-configuration. I don't know what's wrong!!! However
I must say that ALSA it's very powerfull and configurable...
impressioning!


- -----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD8NsIKK3BAIBUkxERAgpHAJwLkRnXq44GVdBYReqw8W9uOXfWnQCfaG+I
m1hEp0q1PEODWQkzBHXRXtU=
=PdAv
- -----END PGP SIGNATURE-----


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD8a97KK3BAIBUkxERAhxxAKCaNd3i0QJ4PIevfZ/eM31Hdh5PPACgk+Xu
NpnijVxIAe1TrtGWDeF0eTM=
=74yt
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
