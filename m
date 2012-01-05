From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: tlv32aic3x, rx-51, regulator
Date: Thu, 05 Jan 2012 13:24:39 +0200
Message-ID: <4F058877.5010005@bitmer.com>
References: <alpine.DEB.2.01.1201051057240.13332@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id ED36124355
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 12:24:56 +0100 (CET)
In-Reply-To: <alpine.DEB.2.01.1201051057240.13332@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 05/01/12 12:02, Peter Meerwald wrote:
> Hello,
>
> the tlv320aic3x codec driver requests a number of supplies/regulators
> (IOVDD, DVDD, AVDD, DRVDD), these seem mandatory for the codec driver to
> operate and somehow tied to the rx51 platform
>
They are the supply voltages for the aix3x codecs and not tied to rx51 only.

> I want to use the tlv320aic3x codec driver with some other board where I
> don't care about supplies/regulators -- how is this going to work? do I
> need to have dummy supplies just to keep tlv320aic3x happy?
>
> shouldn't the ai3x_supply_names be something that is optional and passed
> in via platform_data?
>
Simplest option in case you don't have *any* controllable regulator or 
if the kernel is not touching them is to not enable CONFIG_REGULATOR.

IMHO optional platform data for CONFIG_REGULATOR=y case doesn't win much 
over defining fixed voltage regulators. Either it would be duplicate 
information or needs modification to a machine driver anyway. And the 
regulator framework can be useful in debugging too, like following the 
use_counts via sysfs and so on.

-- 
Jarkko
