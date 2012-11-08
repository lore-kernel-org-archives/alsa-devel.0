From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: Using sync dapm_sync in stream_event call back
Date: Thu, 8 Nov 2012 04:28:43 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C529EEBD@BGSMSX101.gar.corp.intel.com>
References: <32F4D3A311A1404B92CF923AFF38C3C529E715@BGSMSX101.gar.corp.intel.com>
 <20121107144728.GH20844@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 33747265104
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 05:28:48 +0100 (CET)
In-Reply-To: <20121107144728.GH20844@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

>> In my machine driver, I need to disable a widget in stream_event call back.
>> I realized that I cannot invoke dapm_sync() inside the stream_event, because it
>causes recursive lock.
>
>> How can I disable a pin (widget) inside stream_event call back?
>
>This doesn't sound like something that really makes sense within the model
>DAPM has.  What are you actually trying to accomplish?

App is re-routing the audio within codec by changing mixer settings (for a same stream/device).
When app changes a MUX mixer settings, temporarily DAPM path gets broken and shut downs BIAS/CLOCK.
I was planning to use a Virtual Widget which I enable in my open and disable it during stream_event(STREAM_STOP).
This is to make sure BIAS/CLOCK will never shut down, as long as stream is active.
I'm not sure if this is correct way to do it. Any inputs?
