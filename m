From: =?iso-8859-1?Q?Lambrecht_J=FCrgen?= <J.Lambrecht@TELEVIC.com>
Subject: ASoC pr_debug disabled in soc-core.c
Date: Fri, 10 Jun 2011 15:08:29 +0200
Message-ID: <4DF2174D.1020700@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ip2.televic.com (ip2.televic.com [81.82.194.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 3590D103827
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 15:08:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am rather new to linux, and I don't find why 'pr_debug' is disabled in =

/sound/soc/soc-core.c but enabled in /drivers/base/dd.c (can see the =

messages with 'dmesg' or with setting 'loglevel=3D8').
(printk(KERN_DEBUG ...) does work though)

I enabled those configuration options:
- DEBUG_DRIVER
- SND_DEBUG
- SND_VERBOSE_PRINTK
- DEBUG_KERNEL

(SND_PCM_XRUN_DEBUG is disabled)

What am I missing?

Regards,
J=FCrgen

-- =

J=FCrgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
