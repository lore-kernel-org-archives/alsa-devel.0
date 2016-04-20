From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: GPIO control from ALSA
Date: Wed, 20 Apr 2016 11:06:09 +0200
Message-ID: <57174681.2050908@metafoo.de>
References: <571737E4.5030908@barix.com> <57173EEB.5040403@metafoo.de>
 <5717430B.1030109@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CA8266815
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 11:06:10 +0200 (CEST)
In-Reply-To: <5717430B.1030109@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/20/2016 10:51 AM, Petr Kulhavy wrote:
> On 20.04.2016 10:33, Lars-Peter Clausen wrote:
>> On 04/20/2016 10:03 AM, Petr Kulhavy wrote:
>>> Hello,
>>>
>>> I'm writing a driver for ASoC "sound card" hardware which uses CPU GPIO to
>>> mute/unmute an analogue amplifier and another GPIO to control an analogue
>>> switch for line/mic switching. Is there an abstraction in ALSA to model this
>>> kind of hardware?
>> There is no abstraction. Use controls and/or DAPM and the standard GPIO API,
>> if you grep the sources you'll find a few examples of drivers using GPIOs to
>> mute amplifiers and similar (e.g. qi_lb60).
>>
>> - Lars
> 
> Thanks, Lars, for the good pointers! I will check that out.
> 
> Is there also a way to map GPIO to a control which then appears e.g. in
> alsamixer? That would be useful for the mic/line selection.

Rather than exposing the GPIO itself you'd expose the logical function of
the GPIO. E.g. in your case a ENUM control that allows to switch between
microphone and capture and in the background this sets the GPIO according to
the selection.

- Lars	
