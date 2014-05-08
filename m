From: Ralf Beck <musical_snake@gmx.de>
Subject: Re: [PATCH] rawmidi.c Set a name for a newly allocated
 rawmidi substream
Date: Thu, 08 May 2014 08:07:23 +0200
Message-ID: <536B1F1B.5070205@gmx.de>
References: <536A6C3D.6080906@gmx.de> <536A6FE2.20109@ladisch.de>
Reply-To: ralfbeck1@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 497CD265469
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 08:07:26 +0200 (CEST)
Received: from [192.168.2.173] ([178.13.30.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MQ33z-1Wlpqy45fn-005JRH for
 <alsa-devel@alsa-project.org>; Thu, 08 May 2014 08:07:24 +0200
In-Reply-To: <536A6FE2.20109@ladisch.de>
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

Am 07.05.2014 19:39, schrieb Clemens Ladisch:
> Ralf Beck wrote:
>> Rationale: Bitwig Studio (and possibly other rawmidi clients) 
>> enumerate the Midi I/Os by substream names. With the current rawmidi 
>> implementation, the name is an empty string and only the USB 
>> mididriver changes it to a meaningful value after allocation. 
> Many RawMIDI devices have only one substream, or multiple substreams 
> that are merged into one port. For these, separate substream names do 
> not make sense. 
Any having no substream name at all makes more sense?
>> This patch sets a default substream name of the form "somename x-y-z" 
> The ID string is not meant to be a name. 
Would it be acceptable, if i remove the ID string and only return x-y-z ?
Other than the alsa developers i would call creating rawmidi substreams, 
but not
assigning a name to them a bug.

Best regards,
Ralf
