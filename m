From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 11/11] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Mon, 06 Jul 2009 18:10:25 -0700
Message-ID: <4A52A081.9070003@boundarydevices.com>
References: <1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-12-git-send-email-troy.kisky@boundarydevices.com>
	<20090705130352.GE5334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 016A0245BB
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 03:10:36 +0200 (CEST)
In-Reply-To: <20090705130352.GE5334@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Sat, Jul 04, 2009 at 07:30:01PM -0700, Troy Kisky wrote:
> If you mean that it should start and
> stop the clocks
Yes.

> that causes issues in situations like TDM since there
> can be transfers going on independantly of the CPU which may need the
> clocks running.  Not everything will be able to gate the clocks, too.

What is TDM? time division multiplexing? You mean the frame carries
more than just audio data? I think I'm misunderstanding something.
Can you elaborate please.


> 
> In any case, this looks like a separate patch that should be split out
> of this one.
> 
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		/* reading ram before asp should be safe
>> +		 * as long as the asp transfers less than a ping size
>> +		 * of bytes between the 2 reads
>> +		 */
>> +		edma_get_position(prtd->ram_master_lch,
>> +				&ram_src, &ram_dst);
>> +		edma_get_position(prtd->asp_master_lch,
>> +				&asp_src, &asp_dst);
>> +		count_asp = asp_src - prtd->asp_params.src;
>> +		count_ram = ram_src - prtd->ram_params.src;
>> +		mod_ram = count_ram % period_size;
>> +		mod_ram -= count_asp;
> 
> Is it perhaps saner to just look at the current position as being the
> position of the transfer to SRAM?  This does mean more variation from
> the point at which data is audibly playing but on the other hand as far
> as the CPU is concerned once the audio gets to SRAM it can't work with
> it any longer so it's potentially misleading to report the SRAM
> position.  Not all hardware will be able to report the position at all
> so userspace ought to be able to cope.

Hmm. Good point. I just wanted as accurate lip-sync as possible.

> 
>> +	iram_virt = sram_alloc(iram_size, &iram_phys);
>> +	if (!iram_virt)
>> +		goto exit2;
> 
> Should this perhaps be configured via platform data?  You've currently
> picked 7 * 512 bytes but there appears to be no urgent reason for that
> particular number and presumably SRAM is a limited resource which people
> may want to prioritise differently.  That may mean having bigger buffers
> for audio as well as less - things like MP3 players can get better
> battery life by setting up very big DMAs.  On a similar vein is it worth
> considering making this feature entirely optional and/or falling back to
> non-SRAM if SRAM allocation fails?

Yes Chris Ring also asked for that, and it is fairly easy to allocate another
SDRAM buffer to use for the SRAM. But I'd rather another patch after this
if I need to use plaform data. Maybe audio_sram_buffer_size = 0 in platform
data to mean use SDRAM?
