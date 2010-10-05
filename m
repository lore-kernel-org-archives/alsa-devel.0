From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: asihpi: Control naming
Date: Tue, 05 Oct 2010 11:47:12 +0200
Message-ID: <4CAAF420.9090805@ladisch.de>
References: <4CA4078E.6010601@audioscience.com>
	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>
	<s5haamz9che.wl%tiwai@suse.de>	<4CAAB343.9040603@audioscience.com>
	<4CAACEAF.2070208@ladisch.de> <4CAADE8F.9030104@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 9B9CB10391D
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 11:46:35 +0200 (CEST)
In-Reply-To: <4CAADE8F.9030104@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> On 05/10/10 20:07, Clemens Ladisch wrote:
> > Capture controls affect audio data that is recorded by the computer.
> > Playback controls affect audio data that comes out of the sound card.
> 
> OK. I think everything fits one of these two.
> 
> I find the asymmetry a little odd. (i.e. Capture controls defined by
> destination of PCM Capture, while Playback controls not defined by
> source of PCM Playback)

In both cases, it's the destination that determines the type.

When it comes to partitioning the controls into two groups according
to overall direction, using the destination makes the most sense in
practice.

> I.e. in reality they are "Capture" and "Output"

Yes, but this naming convention is already there for hysterical raisins.


Regards,
Clemens
