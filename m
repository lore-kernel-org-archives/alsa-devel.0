From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Opening dev/dsp takes very long
Date: Sat, 13 Mar 2004 21:01:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40536881.4030903@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi !

I switched from 2.4 to 2.6 a few days ago and noticed this strange
problem. Whatever program uses OSS-emulation takes 1-3 seconds to open
/dev/dsp and start playing sound. It seems that this has something to do
with the preemptive kernel option, because I experienced the same when I
tried a 2.4 kernel with the preemptive patch.
I thought that having a prememtive kernel would reduce delays in general
~ and not increase them dramatically.
How can I be of help to find and locate this problem ?

Greetings,

Lars.

PS: Hardware is EWX24/96, if that helps.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAU2iBrp9JEomxNXERAuAtAJ0SqH7CtAidytYox5ZmWw1gOfMIpACdHRf6
xJQw7Ug3+gvimU11ECwGY4c=
=ko6Q
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
