From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: underruns and POLLERR when copying audio frames
Date: Wed, 21 Jul 2010 12:20:10 +0200
Message-ID: <4C46C9DA.6010401@gmail.com>
References: <4C4581D9.8020309@gmail.com> <4C45A77B.4070802@ladisch.de>
	<4C462827.10105@gmail.com> <4C469CAC.3030202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F2942454A
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 12:20:16 +0200 (CEST)
In-Reply-To: <4C469CAC.3030202@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Stefan Schoenleitner wrote:
>> Clemens Ladisch wrote:
>>> How do you synchronize the clocks of both devices?
>> I don't.  [...]
>> I guess if clock drift gets too high, I will get xruns as well ?
> 
> Yes.

Hmm, ok.
For now I will just add buffering and hope that the buffer is big enough
 so that there will be no xruns for reasonable long amounts of time.
In case I get troubles anyway, is there some kind of way to synchronize
clocks between the ALSA stack running on one system with the stack on
another system ?


>> But as mmapping just seems to work for files, I no longer think it is
>> possible.
> 
> Some optimization is possible even when only one device supports mmap:
> When you want to copy from the hardware device to the plugin, you could
> call the plugin's snd_pcm_writei with an address in the sound card's
> buffer as the source.

right.

Thanks four your input,

cheers,
stefan
