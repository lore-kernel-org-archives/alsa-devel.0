From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Jabra SPEAK 410 USB - no audio playback
Date: Fri, 16 Dec 2011 14:49:05 +0100
Message-ID: <4EEB4C51.4010205@ladisch.de>
References: <20111210142419.GC16692@amd.home.annexia.org>
	<20111210194539.GF16692@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A7BAE103919
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 14:46:54 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0361020D86
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 08:46:53 -0500 (EST)
In-Reply-To: <20111210194539.GF16692@amd.home.annexia.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Tom Walder <tom.walder@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Richard W.M. Jones wrote:
> The attached patch fixes USB audio support for the Jabra SPEAK 410 USB.
>
> The problem, as I understand it, is that the device contains a
> Class-Specific Endpoint (CS_ENDPOINT) descriptor before the Endpoint
> (ENDPOINT) descriptor.  The USB code all assumes that CS_ENDPOINT can
> only appear after ENDPOINT.  Therefore the USB code divides up the
> interface descriptor into "stuff before ENDPOINT" (in
> interface->extra) and "stuff after ENDPOINT" (in
> interface->endpoint[0]->extra).  For this device, this division does
> not work.
>
> The solution (which is a hack ...) is to also search interface->extra
> looking for the missing descriptor.

The patch looks good.  Please run it through checkpatch.pl and provice
a Signed-off-by tag (see Documentation/SubmittingPatches).


Regards,
Clemens
