From: Robert Tiemann <rtie@gmx.de>
Subject: Re: Sample format changes by plugin while playing
Date: Fri, 20 Apr 2018 09:37:16 +0200
Message-ID: <2d6ea183-4ff9-beb7-50b8-a0843f6d63a1@gmx.de>
References: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
 <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
 <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
 <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
 <7c046ed4-9f38-31d3-61b7-b8b68bd5054c@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A57E8266CA1
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 09:37:17 +0200 (CEST)
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1eTC2H3SHZ-00gFED for
 <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 09:37:16 +0200
In-Reply-To: <7c046ed4-9f38-31d3-61b7-b8b68bd5054c@ladisch.de>
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


On 04/19/2018 05:57 PM, Clemens Ladisch wrote:
> Robert Tiemann wrote:
>> I guess "in theory" means that you don't know about any plugin of such
>> kind I could take a look at, right?
> 
> No; most plugins force the configuration of the slave to be similar, and
> to be done at the same time as their own.

So a plugin can configure its slave the way it likes? Would it be
possible to change the slave configuration multiple times during
playback (close/open slave would be OK for me)?

> PulseAudio does something similar to this, but it's much more complex
> than just an ALSA plugin.

I'd like to avoid PulseAudio for my case. Basically, I have the choice
between writing an ALSA plugin for a generic and transparent solution,
or implementing the functionality in the playback software.

The latter solution would be rather messy, I suspect, and be
restricted to individual players (currently, I need to support two
different players, both doing their things in very different ways).
Anyway, taking a look a PulseAudio won't hurt if it cannot be done as
ALSA plugin.
