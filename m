From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: Yet another problem running latencytest
Date: Sun, 30 May 2004 13:29:23 -0400
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040530172926.EKZT4171.smtp3.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I've recompiled my 2.6.5 kernel with rtc compiled in and was able to install
latency-test module. However, now when I run the run_tests the program goes
through initial 2 "draw 500x500 square" tests and then every following test
simply does something like this:

starting diskread (or whatever else is being tested) test..............
error opening device

I've properly edited the latencytest.config file to reflect the proper
directories and I can see that the tmpfile1 and tmpfile2 are being generated
during the tests (and the disk is working) but at the end of the test all
the logfiles are empty and there are no png files in the test directory.

I do not have a /dev/midi0 in my /dev folder (I think mdk 10.0 community I
am using uses devfs), but even if I created a sym-link to /dev/midi00 which
does exist, it still failed.

Any ideas?

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
