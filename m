From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: asihpi: Control naming
Date: Tue, 05 Oct 2010 21:14:57 +1300
Message-ID: <4CAADE81.6030308@audioscience.com>
References: <4CA4078E.6010601@audioscience.com>	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>	<s5haamz9che.wl%tiwai@suse.de>
	<4CAAB343.9040603@audioscience.com> <4CAACEAF.2070208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 85BDF103826
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 10:15:10 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P32fz-0002o5-L9
	for alsa-devel@alsa-project.org; Tue, 05 Oct 2010 10:15:07 +0200
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2010 10:15:07 +0200
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2010 10:15:07 +0200
In-Reply-To: <4CAACEAF.2070208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
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
