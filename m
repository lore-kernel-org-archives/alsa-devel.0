From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Synchonize video with audio playback
Date: Thu, 7 Apr 2016 16:26:23 +0200
Message-ID: <57066E0F.4090206@ladisch.de>
References: <3CD7D8096827214EA72BFDC6B95C7CC931B668D6@VEREXCH02.harrisbroadcast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 78C862650CC
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 16:26:25 +0200 (CEST)
In-Reply-To: <3CD7D8096827214EA72BFDC6B95C7CC931B668D6@VEREXCH02.harrisbroadcast.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li, Steve" <Steve.Li@imaginecommunications.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Li, Steve wrote:
> I am wondering what is the best way to synchronize video playback with
> audio. What kind of timing information can I query through the ALSA
> interface in terms of the audio playback?

snd_pcm_delay() gives you the number of samples currently in the queue
between your application and the speaker.


Regards,
Clemens
