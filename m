From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: NULL pointer dereference in ALSA triggered	through
 saa7134-alsa
Date: Mon, 10 Aug 2009 19:06:29 +0300
Message-ID: <4A804585.9060908@pardus.org.tr>
References: <4A8025BF.7030404@pardus.org.tr>
	<s5hab27n501.wl%tiwai@suse.de>	<4A803FDC.8070005@pardus.org.tr>
	<s5hocqnllcg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C9B23247E7
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 18:06:31 +0200 (CEST)
In-Reply-To: <s5hocqnllcg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> But /usr/include/sound isn't used for building kernel modules normally.
> Unless any hack is added, these files have to be installed to the
> kernel header directory.
>   

Ah you're right, I totally missed that one. Thanks, will try to
workaround that.
