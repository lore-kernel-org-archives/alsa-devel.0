From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: Declaring HDMI channel allocation to kernel
Date: Tue, 24 Jul 2012 12:43:43 -0500
Message-ID: <500EDECF.5000902@ti.com>
References: <500D5D3D.2060108@gmail.com> <500DA87A.8080901@linux.intel.com>
 <500E9565.2040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 0495A265254
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 19:44:43 +0200 (CEST)
In-Reply-To: <500E9565.2040102@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Gabriel,

On 07/24/2012 07:30 AM, Gabriel M. Beddingfield wrote:
> On 07/23/2012 02:39 PM, Pierre-Louis Bossart wrote:
>> On 7/23/2012 9:18 AM, Gabriel M. Beddingfield wrote:
>>>
>>> Is there an established way for me (from userspace) to pass the HDMI
>>> Channel Allocation (1 byte) to the driver?  If not, can you recommend
>>> an approach?
> [snip[
>> I believe this is one of the topics that will be presented by Takashi at
>> LPC, we need the ability to specify a arbitrary sink-specific channel
>> mapping.
>
> OK, thanks!  So then, to do this today I need to add my own special sauce.

FWIW, in the past I could use the route plugin to achieve arbitrary 
channel mapping. This was done by SW, though. The details are here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-April/051573.html

Ricardo
>
> -gabriel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
