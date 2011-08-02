From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Copy ALSA buffer to the buffer allocated in my
	driver.
Date: Tue, 02 Aug 2011 15:07:39 +0200
Message-ID: <4E37F69B.4070104@ladisch.de>
References: <CAB+ez9uo=4ruqp0yXXJ9Ny=GRXVP6ALYYvhHaTEbp_D9y7AgPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 116CC103816
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 15:04:11 +0200 (CEST)
In-Reply-To: <CAB+ez9uo=4ruqp0yXXJ9Ny=GRXVP6ALYYvhHaTEbp_D9y7AgPg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: `/ET!-i1S!-i <yethish7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

`/ET!-i1S!-i wrote:
> 1. I have no idea how to copy the alsa buffer to intermediate buffer (my
> Buffer) for playback application .
> 2.  I have taken dummy driver code as example.
> 3. Can you please help me. What code has to be included in the below copy
> function to copy alsa buffer to my Buffer.

Something like copy_from_user().
See sound/pci/rme9652/hdsp.c for an example.


Regards,
Clemens
