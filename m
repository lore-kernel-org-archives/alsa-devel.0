From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to tell user level hardware not support
 a	certain format in a certain sample rate
Date: Mon, 02 Mar 2009 16:58:42 +0100
Message-ID: <49AC0232.1060909@ladisch.de>
References: <4e090d470902222302g16a99f5dq77d0d40f6cba855e@mail.gmail.com>
	<4e090d470903020604h27ce2ce8l47f996edc9764ada@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 93D6C243B3
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 16:58:39 +0100 (CET)
In-Reply-To: <4e090d470903020604h27ce2ce8l47f996edc9764ada@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Richard Zhao wrote:
> runtime->hw.rates and runtime->hw.formats indicate the rate and
> formats hardware can support, so the user level plugins can
> auto-convert the audio data. But hardware may not support a certain
> combin of sample rate and format,

Did you install your own constraint rules, as described in section
"Constraints" of "Writing an ALSA Driver"?


Best regards,
Clemens
