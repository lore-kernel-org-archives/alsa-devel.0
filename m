From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ASoC: DaVinci: Audio: Fix swapping of
	channels at start of stereo playback
Date: Thu, 13 Nov 2008 06:57:11 -0800
Message-ID: <877i77k720.fsf@deeprootsystems.com>
References: <1226465791-14725-1-git-send-email-naresh@ti.com>
	<20081112115001.GC8767@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 37EAB2458C
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 15:57:16 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so675410ywk.2
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 06:57:16 -0800 (PST)
In-Reply-To: <20081112115001.GC8767@sirena.org.uk> (Mark Brown's message of
	"Wed\, 12 Nov 2008 11\:50\:02 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: davinci-linux-open-source@linux.davincidsp.com, naresh@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Wed, Nov 12, 2008 at 10:26:31AM +0530, naresh@ti.com wrote:
>
>> Fixes swapping of channels at start of stereo playback.
>> 
>> Channel swap can be observed while playing left-only or right-only audio data. The channel 
>> swap is fixed by handling the XSYNCERR condition.
>> 
>> Signed-off-by: Naresh Medisetty <naresh@ti.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>

OK, pulling into DaVinci git and will drop when resync with next ASoC.

Kevin
