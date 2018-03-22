From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8824: user configuration of key
	detection
Date: Thu, 22 Mar 2018 10:41:00 +0800
Message-ID: <5AB317BC.3080108@nuvoton.com>
References: <1521617423-2213-1-git-send-email-KCHSU0@nuvoton.com>
 <20180322020714.GA2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 34BD8267282
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 03:41:22 +0100 (CET)
In-Reply-To: <20180322020714.GA2186@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 3/22/2018 10:07 AM, Mark Brown wrote:
> On Wed, Mar 21, 2018 at 03:30:23PM +0800, John Hsu wrote:
>> The SAR ADC of key press detection varies depending on headset.
>> We can't make a set of common threshold values for every case.
>> Therefore, the driver provides configuration for user and
>> they can set up values by UCM configuration.
>
> It's more normal for this configuration to be done as part of the
> platform bindings for the device, with the values being tuned based on
> the in box headset and the tastes of the system integrator, seeing this
> exposed as a userspace control is a bit surprising - what motivated
> that?
>
> If we are going to have this tunable from userspace we probably want a
> standard interface for it so that the userspace software can work more
> generally.  However that's a bit tricky as the tunable parameters are
> going to vary...

There is binding values in devicetree or ACPI when product shipping.
Sometimes users find the wrong response of key press when they use their
specific headset. That means they have to tune their SAR threshold of chip,
and they need our support for the values. But the value is kept in ACPI,
and it's not easy for the user to adapt the new one which we provide.
I think the easy way is that they can put the values in UCM and happy to
use their favorite headset.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
