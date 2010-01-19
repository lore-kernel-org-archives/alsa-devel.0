From: Raul Xiong <raulxiong@gmail.com>
Subject: Can we add optional parameters in snd_pcm_hw_params
Date: Tue, 19 Jan 2010 21:35:10 +0800
Message-ID: <358341421001190535o616ff737m15851b124402950e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 54B0024370
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 14:35:15 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so272122qwc.56
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 05:35:14 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi all,

In my current ALSA driver, I have defined a mode which will impact the
configuration of the audio driver. The requirment is to ask application
users to set this mode to driver. So I want to add a parameter in 'hwparams'
of snd_pcm_hw_params(pcm_handle, hwparams). But it seems that ALSA have no
such expansibility.

Basically, my requirment is: There are two modes: ModeA and ModeB. I'd like
application to set this mode before it begin playing. If you have other
better methods to reach this requirment, it's also welcome. Thanks.
