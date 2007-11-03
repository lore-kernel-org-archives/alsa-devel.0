From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: [PATCH] hda: STAC9228 DMIC
Date: Sat, 03 Nov 2007 07:54:57 -0600
Message-ID: <472C7DB1.4000807@canonical.com>
References: <472A3C34.2080503@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.globalsuite.net (mail.globalsuite.net [69.46.103.200])
	by alsa0.perex.cz (Postfix) with SMTP id 588862463F
	for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2007 14:55:09 +0100 (CET)
In-Reply-To: <472A3C34.2080503@embeddedalley.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Matthew Ranostay wrote:
> Added support for the dmics and enabled EAPD for several laptops with 
> STAC9228 cards.
> ---
> Signed-off-by:  Matthew Ranostay <mranostay@gmail.com>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

ACK on this patch. It enables the Dell XPS 1330 built-in digital 
microphone. External speakers still work, though I have not tested for 
regressions such as headphone jack sensing.

-- 
Tim Gardner tim.gardner@ubuntu.com
