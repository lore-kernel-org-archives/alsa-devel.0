From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Broken outmixer_event function in
	wm8400/wm8990/wm8991
Date: Tue, 13 May 2014 15:22:22 +0100
Message-ID: <20140513142222.GM25203@opensource.wolfsonmicro.com>
References: <5370840E.10009@metafoo.de> <20140512204734.GO12304@sirena.org.uk>
 <20140513135305.GL25203@opensource.wolfsonmicro.com>
 <537227F7.9000609@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FD622654D8
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 16:22:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <537227F7.9000609@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2014 at 04:11:03PM +0200, Lars-Peter Clausen wrote:
> On 05/13/2014 03:53 PM, Charles Keepax wrote:
>> On Mon, May 12, 2014 at 09:47:34PM +0100, Mark Brown wrote:
>>> On Mon, May 12, 2014 at 10:19:26AM +0200, Lars-Peter Clausen wrote:
>> I would be inclined to go with the custom put/get method as well,
>> but it leaves a question of what to do if the user sets an
>> invalid value. Refusing to set the control feels nicer, but adds
>> an ordering limitation on setting the controls. Updating the
>> conflicting control is also possible, but might be a little
>> surprising?
>
> The event PRE_REG event is generated as soon as the control is changed, 
> not when the path powers up. So there is no difference to a custom put 
> handler in this regard.

Right, thanks, in that case yeah I can see no reason not to
switch to a custom put. I will shove it on the todo list.

Thanks,
Charles
