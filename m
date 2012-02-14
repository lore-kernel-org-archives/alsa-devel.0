From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Tue, 14 Feb 2012 09:29:27 +0800
Message-ID: <CAN8cciaa4Htu5cS7AGuX347xY_Vbx5Uk9i4f605MRVmTQthtmw@mail.gmail.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BDDBA103CF4
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 02:29:29 +0100 (CET)
Received: by wera1 with SMTP id a1so4134793wer.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 17:29:28 -0800 (PST)
In-Reply-To: <s5h39aj5569.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/2/10, Takashi Iwai <tiwai@suse.de>:

>
> I'd like to hear rather comments from others.
>

1) The problem of core jack api which is tailor made for embedded
device, it assume there is only one sound card

when the desktop computer have more than one sound cards which have jack detect
there is no mapping to which sound card has the events.

How to differentiate . noboard hdmi port and graphic card's hdmi ?

2) if the objective of adding jack detection is for trapping
plug/unplug event to trigger the reconfiguration of audio server

http://thread.gmane.org/gmane.linux.alsa.devel/89781/focus=89788

does the audio server require to know the initial state of the hdmi
or just need the trigger event ?

3) There are laptops (e.g. alienware) which have two HP jacks and Mic
jack which need jack retasking for support surround5.1 since the name
of volume controls cannot be rename , the only way is to perform a
hda-reconfig or early patching

can those input device be deleted during the hda-reconfig ?
