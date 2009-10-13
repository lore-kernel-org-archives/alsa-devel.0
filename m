From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCHv2 5/7] ASoC: TWL6030: Add support
	for	low-power mode
Date: Tue, 13 Oct 2009 15:15:45 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90D5EE30@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
	<20090928132800.GD31899@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AB601038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 22:15:50 +0200 (CEST)
In-Reply-To: <20090928132800.GD31899@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

Mark Brown wrote:
> On Fri, Sep 25, 2009 at 09:03:30PM -0500, Lopez Cruz, Misael wrote:
>> In high-performance mode, codec can only work at 19.2 MHz from
>> high-performance PLL. All paths supported in the codec can be used
>> but audio can be streamed only at 48 kHz.

> The driver should also set constraints at runtime so that applications
> know they shouldn't use an unsupported sample rate.  See wm8988 for an
> example of doing this - it has some similar SYSCLK based restrictions.

In OMAP4, we can have the processor connected to Audio Backend and
then to Phoenix (OMAP4->ABE->McPDM->TWL6030), but it's also possible
to bypass the Audio Backend (OMAP4->McPDM->TWL6030).

The McPDM link requires data to be sent at twice the desired rate.
In the first scenario (Audio Backend enabled), OMAP4 sends the data
at 48kHz to ABE and it upsamples it to 96kHz and then send to TWL6030
through McPDM. In the second scenario (Audio Backend bypassed),
OMAP4 has to send the audio data at 96kHz, since no upsampling
blocks are available now.

>From TWL6030 CODEC driver pespective, the DAI link supported rate
should be 48kHz or 96kHz? If the final goal is to explicitly represent
all links in the system (ABE, Phoenix, McBSP, etc), then ABE link
should expose somehow that it delives upsampled data. If that assumption
is true, then TWL6030 DAI should support 96kHz.

A second concern is that runtime constraints will prevent rates
supported by the system, when the constraints are only valid for the
link. For example, if the TWL6030 CODEC adds a contraint for 96kHz,
then it prevents the whole system to play 48kHz, which is supported
when ABE is enabled since ABE upsamples it.

-Misa
