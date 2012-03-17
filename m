From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Sat, 17 Mar 2012 14:00:57 +0100
Message-ID: <4F648B09.5090806@ladisch.de>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>	<20120315175310.GR3138@opensource.wolfsonmicro.com>	<CA+7tXijgsT3uitVa-=VLmKY2ubQpgff0hkKjA5jz6QCFp9_PiA@mail.gmail.com>	<20120316192513.GJ3158@opensource.wolfsonmicro.com>
	<4F639BCC.2050703@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7A375103D4D
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 14:01:46 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9017520B23
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 09:01:42 -0400 (EDT)
In-Reply-To: <4F639BCC.2050703@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Trent Piepho <tpiepho@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
> On 03/16/2012 08:25 PM, Mark Brown wrote:
>> On Thu, Mar 15, 2012 at 05:28:13PM -0400, Trent Piepho wrote:
>>> There is a race when the constraints change dynamically.  See the
>>> fsl_ssi.c driver and the sample size constraint in synchronous mode.
>>
>> This is just a limitation of the ALSA ABI - there's nothing we can do
>> about it without changing the userspace interface so we just have to
>> live with it and error out if an application ever manages to hit the
>> race and pick something incompatible with other active streams (note
>> that the symmetric rates support has a dev_warn() complaining about
>> hitting the race).
>
> I think the real problem with this is, that currently a userspace application
> will usually exit with an error when such a race occurs, while it should be
> possible to just restart the enumeration process and try with another format.
>
> So I'm wondering if we can make it easier for userspace to detect that the
> constraints have changed and it may retry with other parameters?

Devices that have such a restriction must be marked with
SNDRV_PCM_INFO_JOINT_DUPLEX.  There is no indication that the race has
actually happened, so applications that care have to retry just in case.


Regards,
Clemens
