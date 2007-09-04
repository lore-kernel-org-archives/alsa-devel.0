From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Improved support for different bt87x	board
	configurations
Date: Tue, 04 Sep 2007 14:54:39 +0100
Message-ID: <1188914079.6535.47.camel@areia>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D75E1037FD
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 15:54:22 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Ok, that's what I did.  The other checkpatch warnings are fixed too. 
 
> +/* Cards with configuration information */
> +enum snd_bt87x_boardid {
> +       SND_BT87X_BOARD_GENERIC,
> +       SND_BT87X_BOARD_ANALOG,         /* board with no external A/D
> */
> +       SND_BT87X_BOARD_HAUPPAUGE878,
> +       SND_BT87X_BOARD_OSPREY2x0,
> +       SND_BT87X_BOARD_OSPREY440,
> +       SND_BT87X_BOARD_ATI_TVWONDER,
> +       SND_BT87X_BOARD_WINFAST2000,
> +       SND_BT87X_BOARD_VOODOOTV_200,
> +       SND_BT87X_BOARD_AVPHONE98,

Hmm... Maybe it would be a good idea to move the board numbers from
linux/drivers/media/video/bt8xx/bttv.h to a separate header (maybe
something like /include/media/bt8xx-cards.h) and use the same board IDs
for both -alsa and -v4l drivers.

This will make easier to associate the audio and video parts for
troubleshooting and newer developments.

Cheers,
Mauro.
