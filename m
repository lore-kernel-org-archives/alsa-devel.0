From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 52/52] bebob: Add support for M-Audio special Firewire
	series
Date: Tue, 25 Feb 2014 23:02:37 +0900
Message-ID: <530CA27D.2000306@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
	<1391006977-11572-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391006977-11572-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Can I request your comment for this patch about a quirk of transaction?

[alsa-devel] [PATCH 52/52] bebob: Add support for M-Audio special 
Firewire series
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071873.html

Let me describe more detail here.

M-Audio Firewire 1814 and ProjectMix I/O often send no response against 
driver's request, even if the device handle the request.

Please see logs in this page:
http://subversion.ffado.org/wiki/MaudioBebob/Firewire1814#Logswithfirewire_ohcianddebug1option

For CMP and Isochronous Resource Management, this quirk works badly. 
When a request from driver is handled by the device but the device don't 
respond, the drivers (firewire_core/snd-firewire-lib) retry the request. 
Then a response for the second request brings error because the 
operation for connection or isochronous resource management is already 
done in device side.

Against this quirk, I want to merge this patch for upstream, because 
there is no drivers for these devices in kernel-land/user-lang. And this 
quirk makes no disorders into Linux Firewire stack or ALSA core. When 
users face these failure, users can recover device state just powering 
off and on.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
