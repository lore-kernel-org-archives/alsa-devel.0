From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Support for Infrasonic Quartet
Date: Tue, 15 Sep 2009 00:28:51 +0200
Message-ID: <4AAEC3A3.40204@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.pilsfree.net (mail.pilsfree.net [81.201.60.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 81A4024421
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 00:28:59 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I am sending patches for Infrasonic Quartet. The card has three external
clock modes therefore I had to modify ice1724.c to support multiple
spdif_master types. While working on the driver, I did some minor fixes
to ak4xxx-adda.c too.

For proc files I added a conversion function from int to string
representing its binary format (quartet.c:get_binary). If you know of an
existing utility, please let me know and I will use it instead. The
binary output helps a lot with debugging.

The quartet patch does not comply with checkpatch.pl in 2.6.27 since the
script throws a false positive for [] in #define.

Thanks a lot for comments.

Best regards,

Pavel.
