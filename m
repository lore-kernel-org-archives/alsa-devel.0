From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: TLV question - ranges not in volume order
Date: Fri, 10 May 2013 08:55:08 +0200
Message-ID: <518C99CC.6050700@canonical.com>
References: <518A3545.8000809@canonical.com>
 <20130509101217.GE7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 541FF2610C1
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 08:55:10 +0200 (CEST)
In-Reply-To: <20130509101217.GE7478@sirena.org.uk>
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
Cc: rex.tsai@canonical.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/09/2013 12:12 PM, Mark Brown wrote:
> On Wed, May 08, 2013 at 01:21:41PM +0200, David Henningsson wrote:
>
>> I recently came across a strange ASoC volume control. In this case,
>> the values are not in volume order, i e, the control is declared
>> something like below. I believe the numbers correctly match the
>> hardware.
>
> Oh, joy.  What driver is this?

I think it's not in the mainline kernel at this point.



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
