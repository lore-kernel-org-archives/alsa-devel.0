From: Florian Schmidt <mista.tapas@gmx.net>
Subject: ANNOUNCE: pcm config tester tool
Date: Sat, 31 Jan 2004 19:34:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040131193444.561968ae.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

i hacked together a little pcm config test program [dirty hack]. Grab it
at 

http://mistatapas.ath.cx:8888/pcm_config_test.tgz

[that's my home machine, so it's not always on].

You can test for periodsizes, counts, samplerates, transfermethods and
formats. You can test either cpature or playback or both..

THis program actually just opens the pcm device for each test and then
tries to set the parameter. on success it is reported to the user. So it
doesn _not_ try to actually output sound. you can use the pcm test
program from the alsa-lib package for this. This program is to find ot
what your hw can do if you don't know.

Here's some usage examples:

./pcm_config_test hw:0,0 --playback --standard-samplerates

test the device for some standard samplerates [see sourcecode for list]
in playback mode

./pcm_config_test hw:0,0 --capture --playback  --samplerates-range 44090
44110

tests for available samplerates in a range for playback and for capture

./pcm_config_test hw:0,0 --accessmethods --formats --playback --capture

well, you get the point..

tapas@mango:~/source/my_projects/pcm_config_test$ ./pcm_config_test
--help

-- alsa-lib pcm device config tester v0.0.1 --
usage: pcm_config_test <pcm-device-name> [options] 

options are:
--playback
--capture
--standard-samplerates
--samplerate-range x y
--standard-periodsizes
--periodsizes-range x y
--standard-periodcounts
--periodcounts-range x y
--formats
--accessmethods

at least one of --capture and --playback is needed. you will also want
at least one of the tests,
pcm device name must be the first argument!

My C stinks though. And the commandline parsing heavily relies on the
user. If you specify a range test, you will have to specify range start
and range end, otherwise you'll confuse the program.

Please report bugs, and tips :)

Flo


-- 
signature :)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
