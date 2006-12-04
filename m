From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Samsung Audio Problem (update)
Date: Mon, 4 Dec 2006 13:43:29 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485292880@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello:
 
With thanks to Tobin Davis, I was able to resolve part of my problem.

With using the latest snapshot of the alsa driver as well as adding

options snd-hda-intel model=laptop-eapd

to the /etc/modprobe.conf file, I was able to get rid of the high
pitched
squeal and have proper audio playback on the internal speakers.

I am still unable to record. For your benefit, I do have some more
Information on the audio device. From the lspci -qn, I got:

Class: 0403
8086:2668	rev03
Subsystem: 144D:C027

Has anyone got audio recording working on this codec and subsystem?

Thank you

Mark Allyn

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
