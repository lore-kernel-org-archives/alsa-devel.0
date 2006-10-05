From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH 0/2] New virtual device snd_disconnected rc3
Date: Thu, 5 Oct 2006 15:52:37 +0200
Message-ID: <200610051552.37812.annabellesgarden@yahoo.de>
References: <200610051253.46779.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200610051253.46779.annabellesgarden@yahoo.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi

Motivation for this came from oopses consistently happening
when my usb-soundcard disconnected.
Takashi and me discussed various fixes and this patch series
tries to implement the result of our discussion.

Changes in rc3: kmalloc with GFP_KERNEL, use linux list

The patch is split into two parts:

  1) snd_disconnected_file, virtual device

  2) wire up snd_disconnected_file, remove obsolete things


      Karsten

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
