From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH RESEND] ASoC: wm8741: Fix setting BCLK and
 LRCLK polarity
Date: Fri, 3 Nov 2017 19:48:14 +0100
Message-ID: <920d4342-ef31-430f-51f0-b2a9994989a9@taudac.com>
References: <1509734068-9693-1-git-send-email-sergej@taudac.com>
 <20171103183729.xhngptij3qgarf5o@sirena.co.uk>
 <320c629f-ac63-8c7b-19c3-8655756c86f7@taudac.com>
 <20171103184613.gm6ya5qbmtsgs7zu@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id D588B266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 19:48:15 +0100 (CET)
In-Reply-To: <20171103184613.gm6ya5qbmtsgs7zu@sirena.co.uk>
Content-Language: en-GB
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
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Am 03.11.2017 um 19:46 schrieb Mark Brown:
> On Fri, Nov 03, 2017 at 07:42:14PM +0100, Sergej Sawazki wrote:
>> Am 03.11.2017 um 19:37 schrieb Mark Brown:
>>> On Fri, Nov 03, 2017 at 07:34:28PM +0100, Sergej Sawazki wrote:
>>>>     (3) 11 =  inverted BCLK, inverted LRCLK <-- Fix this
> 
>>>> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> 
>>> Is this a straight resend - you dropped Charles' ack?
> 
>> Oops, sorry, forgot about Charles' ack. I have created a new patch,
>> made sure it applies and resent.
> 
> Just to be clear when you say it's a new patch you mean it's the same
> patch but rebased?
> 

Right, same content, rebased on current for-next.
