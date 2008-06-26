From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seg fault in libasound
Date: Thu, 26 Jun 2008 14:26:11 +0200
Message-ID: <48638AE3.90003@ladisch.de>
References: <486282A1.7050308@pagestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B7DB824636
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 14:26:16 +0200 (CEST)
In-Reply-To: <486282A1.7050308@pagestation.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jerry Geis <geisj@pagestation.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jerry Geis wrote:
> I am getting a seg fault in alsa.
>
> #2  0xb7d7105f in __assert_fail () from /lib/tls/libc.so.6
> #3  0xb741861f in snd_pcm_area_copy (dst_area=0x81cc62c, dst_offset=0,
>     src_area=0x81cb7ec, src_offset=5223, samples=816,
>     format=SND_PCM_FORMAT_S16_LE) at pcm_local.h:499

This is the "assert(bitofs % 8 == 0)" in snd_pcm_channel_area_addr()
in pcm_local.h.  In theory, this means that some sample is not aligned
to a byte boundary, but it should be impossible to get this error.

Do you have any .asoundrc or asound.conf file?  If yes, please remove
them and try again.


Regards,
Clemens
