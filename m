From: Steve deRosier <derosier@pianodisc.com>
Subject: lib version?
Date: Tue, 27 Apr 2004 11:06:07 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <408EA10F.6070309@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from EXCHANGE01-Srv.pianodisc.com (ip201.pianodisc.com [207.173.133.201] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA24999
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2004 20:01:55 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok, here's my stupid question of the day:

Is there any way for a program to query the alsa-lib to determine the version number?  Ie...  Assuming I'm using the relase of alsa-lib-1.0.4, I'd like to query and get back something that would indicate that I'm using that release (and I don't even care so much if my program is what queries it, I just need some way to figure what version the libasound.so.2.0.0 file is).

Basically here's the senerio I've got:
We've been developing a box for quite a while using alsa, and we've gone through regular upgrades of alsa on each release.   Unfortunately I'm trying to track down a rather serious problem in my client program, but I'm getting stymied due to what I suspect is a library version mismatch.  I got my program hacked up and working ok to a point and then it segfaults.  I replace libasound with a known 1.0.4 and it fails earlier in a different way (perhaps due to one of my hacks to get it working on whatever lib version I had in there).  I'm just trying to figure out why...  and knowing the library version # might get me there.

Any help would be appreciated.

Thanks,
- Steve



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
