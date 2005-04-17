From: Martin Rehak <rehak@pinerecords.com>
Subject: Audiotrak Maya EX5 playback problem
Date: Sun, 17 Apr 2005 07:31:05 +0200
Message-ID: <20050417053105.GC27160@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have $(SUBJ) and have following problem. At certain conditions, there
occur clicks in the output of the soundcard. It doesn't matter on what
application I use for playback. The result is same for aplay, xmms. It
seems the number of 'clicks', which disturbes the playback repeats in
certain frequency and probability at which it occur is greater with 
rising dynamics of sound source.

For sure i tried to play the same sound source under MS Win and
realized, that there is no such problem.

--<cut>--
raven@edmund:~> uname -a
Linux edmund 2.6.11-edmund #1 Tue Mar 15 18:53:04 CET 2005 i686 unknown unknown GNU/Linux
raven@edmund:~> cat /etc/slackware-version 
Slackware 10.1.0
raven@edmund:~> ls /var/log/packages/ | grep alsa-utils
alsa-utils-1.0.8-i486-1
raven@edmund:~> cat .asoundrc
--<cut>--

Kernel is vanilla one with no patches with PREEMPT disabled. Complete
config file can be seen at http://213.168.184.214/~raven/tmp/edmund-config

I know, that this sound card cannot sampling rate 44100Hz but only
48000Hz. This is the reason 'something' (perhaps alsalib) must do
upsample from 44100Hz to 48000Hz. Could be this the cause? How can
I get rid of it?

Thanks a lot for answer
Martin Rehak


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
