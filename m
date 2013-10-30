From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Getting ELD and available chmaps without opening
	device?
Date: Wed, 30 Oct 2013 21:07:35 +0200
Message-ID: <527158F7.6010204@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B84CB2616CB
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 20:07:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by sinikuusama.dnainternet.net (Postfix) with ESMTP id 7901640374
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 21:07:37 +0200 (EET)
Received: from sinikuusama.dnainternet.net ([83.102.40.134])
 by localhost (sinikuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva,
 port 10041)
 with ESMTP id iWSaKKj52A4a for <alsa-devel@alsa-project.org>;
 Wed, 30 Oct 2013 21:07:37 +0200 (EET)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net
 [83.102.40.215])
 by sinikuusama.dnainternet.net (Postfix) with ESMTP id 3FD52402B9
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 21:07:37 +0200 (EET)
Received: from mail.onse.fi (unknown [109.204.245.192])
 by oliivipuu.dnainternet.net (Postfix) with ESMTP id 3595E5FA99
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 21:07:36 +0200 (EET)
Received: from sigma.onse.fi (unknown [109.204.245.233])
 by mail.onse.fi (Postfix) with ESMTPSA id 10A4040255
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 21:07:36 +0200 (EET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I want to read the ELD of a HDMI sink while another playback is ongoing.

I have the device name (e.g. "hdmi:CARD=NVidia,DEV=0"), and normally I'd
open the device, use snd_pcm_info() to get snd_pcm_info_t with which I
can use snd_pcm_info_get_card() and snd_pcm_info_get_device() to get the
necessary information to access the control with snd_ctl_open(),
snd_hctl_open_ctl() etc.

However, since another playback is ongoing I can't open the device. Is
there another way I'm missing, or do I simply have to magically know the
card/device numbers (which in my case is possible with some tricks since
the playback is in the same application, but I'd guess that might not
always be the case)?

Same affects available chmaps from what I can see.

-- 
Anssi Hannula
