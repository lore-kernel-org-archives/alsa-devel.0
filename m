From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: TI codecs and their crazy variable length
	registers
Date: Thu, 31 Jul 2014 09:01:09 +0200
Message-ID: <53D9E9B5.4040303@metafoo.de>
References: <CAKON4OyCqvjLq09+WymcSKRwfLJrSBoLMRWksNO2hKrtR3u3vw@mail.gmail.com>
 <20140730231756.GE17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-029.synserver.de (smtp-out-031.synserver.de
 [212.40.185.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 85E4C261AAF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 09:01:09 +0200 (CEST)
In-Reply-To: <20140730231756.GE17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/31/2014 01:17 AM, Mark Brown wrote:
> On Wed, Jul 30, 2014 at 05:56:36PM -0400, jonsmirl@gmail.com wrote:
>
>> I'm working on a TI codec attached via I2C.  Just to make things
>> interesting the registers have varying byte lengths of - 1,4,8,12,20
>> bytes. What's the best strategy for using regmap with it?
>
> I'd use the reg_read() and reg_write() callbacks to hide the registers
> that will fit in an integer, the rest of the stack can pretend they've
> got 32 bit values which should improve code reuse.[...]

The adau1701 is a driver that for example does this.
