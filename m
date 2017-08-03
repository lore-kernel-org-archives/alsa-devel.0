From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Problem with DoP mode in Chord 2qute USB audio
Date: Thu, 3 Aug 2017 18:48:38 +0200
Message-ID: <951338f4-9813-fd66-3126-291043596194@ivitera.com>
References: <939956ee-4e91-f726-84ee-59a9b9ddafd1@ivitera.com>
 <9feb9dce-db60-3624-02db-f431484c6ea6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FFC8266D9B
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:48:48 +0200 (CEST)
In-Reply-To: <9feb9dce-db60-3624-02db-f431484c6ea6@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
> 
> Suggestions:
> - try with regular PCM @ 176.4Khz 24 bits to rule out issues in the way 
> DSD is depacked from the stream

Regular 176.4/24 was tested against the DSD/DoP, it works just fine, 
eventhough it produces the very same alsa params (the same data stream) 
as DoP.

> - look into the ASYNC endpoint handling. It could be that the host 
> doesn't provide enough data and the device buffer is emptied at some 
> point. USB doesn't clearly define in how much time the host needs to 
> adjust to feedback information, the implementation may have defined its 
> buffer depth assuming a quick correction.

Could it be different for the two streams if both have the same 
period/buffer params, the same altsetting, the same stream bandwidth? 
IIUC the alsa USB driver does not distinguish between regular PCM and 
DoP of the same bitspeed, at least I could not find anything in the API 
when the player sends already DoP-encoded PCM samples (which it does).

Would it make sense to  monitor the USB (kernel) communication with 
wireshark to see whether the async feedback from the soundcard differs 
for PCM and DoP?

Is it OK that the controller throws IRQ every frame?


I very much appreciate your help.

With regards,

Pavel.
