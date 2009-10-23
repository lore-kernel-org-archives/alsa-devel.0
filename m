From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with snd_pcm_writei() function
Date: Fri, 23 Oct 2009 09:39:51 +0200
Message-ID: <4AE15DC7.7060108@ladisch.de>
References: <e0ab60670910221034u498448c5ja4eae8c2f4fd0f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E3B3D24155
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Oct 2009 09:39:55 +0200 (CEST)
In-Reply-To: <e0ab60670910221034u498448c5ja4eae8c2f4fd0f66@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Douglas Lopes Pereira wrote:
> I'm splitting my audio data into 160 bytes buffers but when buffer
> with different size is passed to that function I hear a noise (like
> 'Krrr') on my audio device.

Do you actually pass the correct number of frames?

How do you manage the timing of the snd_pcm_writei() calls?


Best regards,
Clemens
