From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 14:19:49 +0000
Message-ID: <20111121141948.GB22906@opensource.wolfsonmicro.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
	<1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
	<20111121133836.GA22906@opensource.wolfsonmicro.com>
	<CAPo=G1yZ8mUw=68jFo1S03tdE1yUOkpToCvDBaK02YGaO6nAxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D5E72437F
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 15:19:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPo=G1yZ8mUw=68jFo1S03tdE1yUOkpToCvDBaK02YGaO6nAxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2011 at 04:17:02PM +0200, Ujfalusi, Peter wrote:

> Panda does not have Digital Mic, analog Main/Sub mic, and Vibra support in HW.
> Panda is simple in terms of audio. SDP is more like reference design
> with all possible
> audio connection.

Well, that's rather different to what your patch did - I'd expect your
patch would also be avoiding setting up all the not connected stuff on
Panda.  Perhaps what's needed is platform data (which can have a DT
representation when that comes) which represents the differences and can
include the name to use?
