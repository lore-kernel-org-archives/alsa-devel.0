From: Timur Tabi <timur@freescale.com>
Subject: snd_soc_codec_set_cache_io()
Date: Sun, 9 Jan 2011 16:15:54 -0600
Message-ID: <AANLkTikew7_zd1-H+oiirBghFcd176U6t0r-MFAv_DM5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A9093244A6
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 23:16:35 +0100 (CET)
Received: by fxm5 with SMTP id 5so17677480fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 09 Jan 2011 14:16:34 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark,

The comments for snd_soc_codec_set_cache_io() say this:

 * Note that at present this code cannot be used by CODECs with
 * volatile registers.

Is this still true?  I ask because I think I've been able to use this
function in the CS4270 with volatile registers, and it appears to
work.

-- 
Timur Tabi
Linux kernel developer at Freescale
