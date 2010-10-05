From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi: Control naming
Date: Tue, 05 Oct 2010 21:15:11 +1300
Message-ID: <4CAADE8F.9030104@audioscience.com>
References: <4CA4078E.6010601@audioscience.com> <s5h62xng4wm.wl%tiwai@suse.de>
	<4CA4F1D8.50800@audioscience.com> <s5haamz9che.wl%tiwai@suse.de>
	<4CAAB343.9040603@audioscience.com> <4CAACEAF.2070208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id E0E32103B47
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 10:15:15 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L9T00CBZ5LB6U20@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 05 Oct 2010 21:15:12 +1300 (NZDT)
In-reply-to: <4CAACEAF.2070208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/10/10 20:07, Clemens Ladisch wrote:

> Capture controls affect audio data that is recorded by the computer.
> Playback controls affect audio data that comes out of the sound card.

OK. I think everything fits one of these two.

I find the asymmetry a little odd. (i.e. Capture controls defined by
destination of PCM Capture, while Playback controls not defined by
source of PCM Playback)

I.e. in reality they are "Capture" and "Output"
-- 
Eliot Blennerhassett
AudioScience Inc.
