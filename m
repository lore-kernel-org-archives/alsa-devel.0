From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Underrun / Silence playback
Date: Mon, 05 Dec 2011 11:45:32 +0100
Message-ID: <4EDCA0CC.5030603@ladisch.de>
References: <4EDC674A.4030302@sasken.com> <4EDC9403.3080708@ladisch.de>
	<4EDC9732.1030108@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 433A12413B
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 11:43:51 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D9C73210B8
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 05:43:48 -0500 (EST)
In-Reply-To: <4EDC9732.1030108@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan shaikh wrote:
> I have used my threshold as boundary value also and checked the audio
> performance.  I was still getting UNDERRUN's (-32).

Did you actually call snd_pcm_sw_params()?

> I was not able to get how the boundry which i get (1572864000) is more
> than the buffer size (512 X 16) which i have set.

The boundary value is a large multiple of the buffer size.


Regards,
Clemens
