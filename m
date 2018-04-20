From: Robert Tiemann <rtie@gmx.de>
Subject: Re: Sample format changes by plugin while playing
Date: Fri, 20 Apr 2018 09:15:15 +0200
Message-ID: <9bb662ab-83d8-01b9-334c-70b6cebcac38@gmx.de>
References: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
 <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
 <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
 <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
 <alpine.DEB.2.11.1804191626070.5586@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B6D266C1C
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 09:15:16 +0200 (CEST)
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvPgd-1eRf961rnv-010Znu for
 <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 09:15:15 +0200
In-Reply-To: <alpine.DEB.2.11.1804191626070.5586@lnxricardw1.se.axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 04/19/2018 04:34 PM, Ricard Wanderlof wrote:

> I'm curious about this. Do you have a need to reconfigure the sample rate 
> and format while a stream is playing? We had such a use case a while ago, 

Sort of. The input format, however, is fixed in my case. The output
format may be different and must be recovered from the audio stream.
Infrequently, the output format will change while the input format
remains the same.

You can think about it as a compression scheme. I'd like to play such
audio streams without touching any players, that's why I thought about
writing an ALSA plugin for this.

> but ALSA sets up the stream configuration (sample rate etc) when the
> stream is opened (hw_params()) and it doesn't seem to be possible to
> reconfigure it on the fly

This is probably something that my plugin would have to do with its
slave. If this would possible during playback without disrupting the
player, then I'd take this route.
