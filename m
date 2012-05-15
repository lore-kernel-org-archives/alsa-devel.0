From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Staying synced after underrun
Date: Tue, 15 May 2012 10:46:04 +0200
Message-ID: <4FB217CC.6050500@ladisch.de>
References: <D567972935594567ADE30994399E117C@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A619824C82
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 10:46:07 +0200 (CEST)
In-Reply-To: <D567972935594567ADE30994399E117C@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Paul D. DeRocco wrote:
> I'm writing 48KHz stereo to Intel HD audio on my mobo, and I'd like to send
> it in parallel to both the analog and S/PDIF outputs, which share a clock
> source.

Use snd_pcm_link() to ensure that the stream start happens at the same time.
All linked streams are automatically started/stopped when one of them starts/
stops.


Regards,
Clemens
