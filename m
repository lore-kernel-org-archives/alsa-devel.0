From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: asihpi: Control naming
Date: Fri, 01 Oct 2010 15:19:56 +0200
Message-ID: <4CA5DFFC.40004@ladisch.de>
References: <4CA4078E.6010601@audioscience.com>	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>	<s5haamz9che.wl%tiwai@suse.de>	<4CA5010E.4050705@gmx.de>
	<4CA58856.8070505@ladisch.de> <4CA5C69B.4000703@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 35AA9103A0E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 15:19:16 +0200 (CEST)
In-Reply-To: <4CA5C69B.4000703@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sebastian H." <vand2@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sebastian H. wrote:
> Am 01.10.2010 09:05, schrieb Clemens Ladisch:
> > Those are elements where the simple mixer code doesn't know the
> > direction (because the driver author didn't put "Playback" or "Capture"
> > into the name).
> 
> Ok, but I wonder how to interpret this state in which both functions
> return zero.

There are cases where the playback/capture direction is obvious from the
name ("just implement an AI!"), but these can be considered bugs.

In the other cases, the control really doesn't belong to a direction.
(Which doesn't prevent many mixers that have two pages from just
throwing them in with the playback controls.)


Regards,
Clemens
