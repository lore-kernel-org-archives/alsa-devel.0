From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Fri, 04 Jan 2013 10:02:53 +0100
Message-ID: <50E69ABD.40109@canonical.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A05862616B9
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 10:02:56 +0100 (CET)
In-Reply-To: <s5hhamyr1ne.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>
List-Id: alsa-devel@alsa-project.org

On 01/03/2013 11:39 AM, Takashi Iwai wrote:
> The jack retasking of the headphone input is still an open issue.
> I can provide a patch to add the support via "Headphone Jack Mode"
> enum, but David didn't like that approach.

Hmm, I think the final word of that discussion was that you successfully 
convinced me that you were able to implement it in a generic way, and so 
you were going to implement "Headphone Jack Mode" and friends sometime soon?

Meanwhile, there is hda-jack-retask utility (in the alsa-tools package) 
that might be helpful for Jonathan?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
