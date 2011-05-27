From: Liam Girdwood <lrg@ti.com>
Subject: Re: UCM representation questions
Date: Fri, 27 May 2011 10:20:23 +0100
Message-ID: <4DDF6CD7.2070903@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E52@HQMAIL01.nvidia.com>
	<4DD7E644.4010301@ti.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A485B6@HQMAIL01.nvidia.com>
	<4DDE3333.5010907@ti.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A486ED@HQMAIL01.nvidia.com>
	<20110527013153.GA21016@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BA803103AF9
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 11:20:25 +0200 (CEST)
In-Reply-To: <20110527013153.GA21016@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 27/05/11 02:31, Mark Brown wrote:
> On Thu, May 26, 2011 at 10:13:21AM -0700, Stephen Warren wrote:
> 
>> My thought process here was that conflicting devices are probably less
>> common than non-conflicting devices. At least, it seems like that'd be
>> the default assumption of someone writing a UCM file. So, if we list
>> ConflictingDevice(s), then that would often map to an empty list, and
>> you could eliminate the section. If we had to list all compatible
>> devices, by default you'd have to list every device in the UCM verb in
>> almost all cases. That seems like more work.
> 
>> Plus, adding an optional ConflictingDevice list maintains backwards
>> Compatibility with any existing UCM files, whereas adding a mandatory
>> SupportedDevice list doesn't.
> 
> I tend to agree with this - the usual case is that you can have as many
> devices as you like running, the reason for restricting things is more
> normally usefulness rather than physical possibility.
> 
>> I wonder if allowing all lists of devices to be either inclusive
>> SupportedDevice or exclusive ConflictingDevice makes sense, with the
>> default being ConflictingDevice being empty, and SupportedDevice being
>> the entire set of devices? Seems more complex, but probably still
>> workable.
> 
> That makes sense too - if either directive is used we require an
> explicit list, otherwise we assume everything is compatible.

Ok, sounds fine to me too. I just wanted to make sure we had explored both options here.

Thanks

Liam
