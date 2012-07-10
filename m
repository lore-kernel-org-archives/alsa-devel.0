From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Full duplex ALSA-plugin
Date: Tue, 10 Jul 2012 16:39:16 +0200
Message-ID: <4FFC3E94.5060300@perex.cz>
References: <4FFC3C11.4020600@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id D280624393
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 16:37:59 +0200 (CEST)
In-Reply-To: <4FFC3C11.4020600@voiceinterconnect.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Gruber <christian.gruber@voiceinterconnect.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 10.7.2012 16:28, Christian Gruber wrote:
> I was looking for information on writing an echo cancellation ALSA-plugin. So I studied 
> the ALSA-plugin docs and also found several interesting threads in this mailing list. But 
> what I found out, was quiet disillusioning.
> 
> If I understood the ALSA-plugin concept right, there is no possibility to write a plugin 
> working on two streams, a playback and a record stream, simultaneously. One can only write 
> a filter plugin, which works either on a playback stream or a record stream but not both. 
> And there is no possibility to open a full duplex stream (consisting of playback and 
> record) with snd_pcm_open().
> 
> Is there a reason, why full duplex streams are not implemented yet? Or is it planned in 
> the future to implement this feature?

If you want to do some synchronization between two streams, you have to
use own "data sharing" mechanism such as IPC or so..

In other words - implement filters on both playback and capture streams
and implement the required communication between them.

					Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
