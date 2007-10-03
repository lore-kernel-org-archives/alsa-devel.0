From: william estrada <MrUmunhum@popdial.com>
Subject: different user causes 'no such device'
Date: Wed, 03 Oct 2007 12:55:27 -0700
Message-ID: <4703F3AF.8000806@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D94324524
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 21:55:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi guys,

   I have what seams like a interesting problem.  I have written an ALSA app
to record wav files and it runs while I am logged in an terminal as the
logged in Gnome user or root.  But when I su to another user, it can't
find the default sound card.

   I am running FC6.  I tried changing own of /dev/dsp to 'nobody', that did
not work.

   Anyone know of this problem and a fix for it.

   Thanks for your time.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum

> MSGrec - Version 1.1, Mt-Umunhum-Wireless.net
> WavMSG: Paused: enter 'q' to stop, <ENTER> to start.
> ALSA lib confmisc.c:848:(snd_func_card_driver) cannot find card '0'
> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
> ALSA lib confmisc.c:397:(snd_func_concat) error evaluating strings
> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_concat returned error: No such device
> ALSA lib confmisc.c:1248:(snd_func_refer) error evaluating name
> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_refer returned error: No such device
> ALSA lib conf.c:3972:(snd_config_expand) Evaluate error: No such device
> ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM default
