From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH v2] Add M2Tech hiFace USB-SPDIF driver
Date: Mon, 22 Apr 2013 09:40:51 +0200
Message-ID: <5174E983.7050205@ivitera.com>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
 <1360775505-13106-1-git-send-email-ao2@amarulasolutions.com>
 <5172F76C.9040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id EC9F1260306
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 09:40:55 +0200 (CEST)
In-Reply-To: <5172F76C.9040002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, Clemens Ladisch <clemens@ladisch.de>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org



On 20.4.2013 22:15, Daniel Mack wrote:
> On 13.02.2013 18:11, Antonio Ospite wrote:
>> Add driver for M2Tech hiFace USB-SPDIF interface and compatible devices.
>>
>> M2Tech hiFace and compatible devices offer a Hi-End S/PDIF Output
>> Interface, see http://www.m2tech.biz/hiface.html
> 
> Just curious: is there a new version of this patch set coming?

I have read users report large latencies (unable to watch movies) of
hiFace1 in OSX while reportedly they have not identified any major
latency in windows. Perhaps the fixed PCM_PACKET_SIZE
https://github.com/panicking/snd-usb-asyncaudio/blob/master/pcm.c#L25
limiting the period size
https://github.com/panicking/snd-usb-asyncaudio/blob/master/pcm.c#L98
does not have to be a single relatively large value?

Thanks,

Pavel.
