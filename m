From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: lib version?
Date: Wed, 28 Apr 2004 09:05:45 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404280901430.7902-100000@studcom.urz.uni-halle.de>
References: <408EA10F.6070309@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.uni-halle.de [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA07113
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2004 09:06:03 +0200
In-reply-to: <408EA10F.6070309@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> Is there any way for a program to query the alsa-lib to determine
> the version number?

The function snd_asoundlib_version() won't be available before 1.0.5.
For earlier versions, you can try to test if the symbols listed in
alsa-lib/src/Versions are available.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
