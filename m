From: "Timothy E. Krantz" <tkrantz@stahurabrenner.com>
Subject: BUG: cx88 can't find device struct
Date: Fri, 11 Jun 2010 16:52:15 -0400
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAACQaAAE2cqNLuI5vSe3nryTCgAAAEAAAAPuor1woocFMmbldYCOiqTQBAAAAAA==@stahurabrenner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cdptpa-omtalb.mail.rr.com (cdptpa-omtalb.mail.rr.com
	[75.180.132.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A811037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 22:52:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I started looking into this problem a while back and gave up.  Now I decided
to try again.
 
I am running MythDora 12.23 and would like to update the alsa driver to
1.0.23 so that I can use HDMI audio out on my nvidia GT220 card.
 
So I download the alsa-driver-1.0.23.tar.bz file, unpack it, ./configure and
make and make install.
 
When I reboot I can verify the new alsa driver by cat/proc/asound/version
and it is indeed 1.0.23.
 
If I then try to record an analog station I get:
 
Jun  9 14:40:19 mythdora kernel: BUG: cx88 can't find device struct. Can't
proceed with open
Jun  9 14:40:19 mythdora kernel: cx88[1]: Calling XC5000 callback
Jun  9 14:40:19 mythdora kernel: BUG: cx88 can't find device struct. Can't
proceed with open
 
Hmmm, ok the alsa driver implementation updated some kernel header file
perhaps, so I download the latest v4l-dvb tree and compile it and install it
and reboot.
 
Same thing.  No sound on analog recordings.
 
I am sure I am missing some important step or something.
 
Any help would be greatly appreciated!
 
Tim
