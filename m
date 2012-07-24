From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Declaring HDMI channel allocation to kernel
Date: Tue, 24 Jul 2012 07:30:29 -0500
Message-ID: <500E9565.2040102@gmail.com>
References: <500D5D3D.2060108@gmail.com> <500DA87A.8080901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A33A26527C
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 14:30:38 +0200 (CEST)
Received: by yenr13 with SMTP id r13so6266669yen.38
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 05:30:40 -0700 (PDT)
In-Reply-To: <500DA87A.8080901@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/23/2012 02:39 PM, Pierre-Louis Bossart wrote:
> On 7/23/2012 9:18 AM, Gabriel M. Beddingfield wrote:
>>
>> Is there an established way for me (from userspace) to pass the HDMI
>> Channel Allocation (1 byte) to the driver?  If not, can you recommend
>> an approach?
[snip[
> I believe this is one of the topics that will be presented by Takashi at
> LPC, we need the ability to specify a arbitrary sink-specific channel
> mapping.

OK, thanks!  So then, to do this today I need to add my own special sauce.

-gabriel
