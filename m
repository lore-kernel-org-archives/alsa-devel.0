From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] davinci: da850evm: enable mcasp
 ping-pong bufs and evq's
Date: Fri, 20 May 2011 10:05:40 +0100
Message-ID: <4DD62EE4.7050707@ti.com>
References: <cover.1305723716.git.bengardiner@nanometrics.ca>
	<f02f2bda26f87fff2bb9e958baa12672cae7e362.1305723716.git.bengardiner@nanometrics.ca>
	<20110519211406.GE18849@opensource.wolfsonmicro.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CFDD2CE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE37103A94
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 11:05:48 +0200 (CEST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CFDD2CE@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>, Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Subhasish Ghosh <subhasish@mistralsolutions.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On 20/05/11 08:08, Nori, Sekhar wrote:
> Hi Mark,
> 
> On Fri, May 20, 2011 at 02:44:06, Mark Brown wrote:
>> On Wed, May 18, 2011 at 09:27:46AM -0400, Ben Gardiner wrote:
>>> The davinci-mcasp driver will copy the platform data specified sram sizes and
>>> eventq's.
>>>
>>> Set the event queues and sram sizes for da850. 8K SRAM buffers are selected
>>> because it is the minimum that resulted in the same period size when testing
>>> 48KHz S16_LE stereo. Event queues 0 and 1 are assigned to match those 
>>> specified by Troy Kisky in his introduction of ping-pong buffers for dm644x.
>>>
>>> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
>>
>> Davinci folks, are you OK with this?
> 
> No, please don't merge this just yet. As Ben mentioned in his cover
> letter, the default SRAM pool on DA850 is not suitable for Audio
> transfers. This patch depends on SRAM not being available for audio
> usage in spite of the platform asking for it. This is liable to break.
> 
> The SRAM allocation on DaVinci and OMAP is under a bit of flux and
> once that is sorted out, this patch should be safe to merge. So,
> this probably needs to wait for 2.6.41.
> 

Ok.

Sekhar, Ben, please resend with Acks when the DaVinci depedencies have been merged.

Thanks

Liam
