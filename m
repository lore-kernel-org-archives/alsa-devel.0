From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Sun, 14 Mar 2010 09:29:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003140918410.4672@eeebox2.perex-int.cz>
References: <s5htyswpb18.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1003110824390.4672@eeebox2.perex-int.cz>
	<a3ef07921003111015x2386cc80x73a2a4bd679b1fe1@mail.gmail.com>
	<alpine.LNX.2.00.1003111927570.4672@eeebox2.perex-int.cz>
	<a3ef07921003112032v3c3effb8n7e8f6599f4cbb453@mail.gmail.com>
	<alpine.LNX.2.00.1003120905250.4672@eeebox2.perex-int.cz>
	<a3ef07921003121120h7b2b3289q7863de625f50e5d@mail.gmail.com>
	<alpine.LNX.2.00.1003131410550.4672@eeebox2.perex-int.cz>
	<a3ef07921003131037q21ad995fwd046dba0e9fa1ef7@mail.gmail.com>
	<alpine.LNX.2.00.1003131955590.4672@eeebox2.perex-int.cz>
	<a3ef07921003131222i121a8d54nba5dd3fbcdae3ac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B64FF1037F1
	for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2010 09:29:19 +0100 (CET)
In-Reply-To: <a3ef07921003131222i121a8d54nba5dd3fbcdae3ac0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 13 Mar 2010, VDR User wrote:

> [pid  9629] 1268511516.215224 ioctl(18, 0x400c4150, 0xb43631a4) = 0

^^^^ here xine feeds new samples to the ALSA driver 
(0x400c4150 == SNDRV_PCM_IOCTL_WRITEI_FRAMES)

> [pid  9629] 1268511516.215275 ioctl(18, 0x80044121, 0xb43632cc) = 0
> [pid  9627] 1268511520.700109 ioctl(10, 0xc0104652, 0xb5443f00) = 0
> [pid  9629] 1268511520.700340 ioctl(18, 0x80044121, 0xb43632cc) = -1
> EPIPE (Broken pipe)

^^^^ next iteration (0x80044121 == SNDRV_PCM_IOCTL_DELAY) - see time 
difference - 4.485 seconds from last WRITEI

It seems like a xine bug or the system scheduler bug or any kernel bug 
affecting the system scheduler. The ALSA subsystem is not reponsible for 
this behaviour - the ring buffer in your case is for about 0.372 seconds 
of samples. This limit must not be crossed for the click-free playback.

Ask the xine developers for more help or try another player.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
