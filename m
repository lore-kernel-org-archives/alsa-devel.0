From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH] ASoC: codecs/wm8978: Only reconfigure
 GPIO1 when used for PLL output
Date: Thu, 15 Nov 2012 14:35:59 -0500
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3459CEDE0F1@dekaexchange07.deka.local>
References: <1352482418-64950-1-git-send-email-emillbrandt@dekaresearch.com>
 <20121113064410.GE18224@opensource.wolfsonmicro.com>
 <0A40042D85E7C84DB443060EC44B3FD3459CEDE0D5@dekaexchange07.deka.local>
 <20121115052036.GE7599@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 24558261625
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 20:36:04 +0100 (CET)
In-Reply-To: <20121115052036.GE7599@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 2012-11-15 Mark Brown wrote:
> On Tue, Nov 13, 2012 at 09:43:08AM -0500, Eric Millbrandt wrote:
>
>> However, I agree that the handling of the pin is odd.  Does OPCLK
>> really need to be reconfigured as input whenever the PLL values are
>> updated?  I didn't see anything in the user manual to suggest that that
>> needed to be
> done.
>
> It should not be a requirement of the device itself.  It might be a
> requirement of something using the clock but the system doing that
> should take care of remuxing the pin as needed.  What I'd suggest doing
> here is removing the management of the pin completely from this
> function.

That sounds reasonable.  I'll make those changes and resubmit.

Eric




This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
