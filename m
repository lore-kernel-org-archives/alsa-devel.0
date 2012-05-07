From: James Milne <jamesm@filmlight.ltd.uk>
Subject: Re: Issue with RME HDSPe AIO latency
Date: Mon, 7 May 2012 18:02:41 +0100
Message-ID: <26969FEF-0021-4DD1-B9E9-50419CD411F2@filmlight.ltd.uk>
References: <966796f1b91b7bc3fee7ce5b7779be75@filmlight.ltd.uk>
	<4FA7F92B.8090107@drcomp.erfurt.thur.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b.mx.filmlight.ltd.uk (b.mx.filmlight.ltd.uk [77.107.81.251])
	by alsa0.perex.cz (Postfix) with SMTP id 1D3E524464
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 19:02:26 +0200 (CEST)
In-Reply-To: <4FA7F92B.8090107@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Adrian,

Thanks for the reply. In the end it transpired our code was always trying to keep the buffers full, but that meant it was 16384 samples ahead of the hardware pointer. There was another bug which meant this delay wasn't taken into account when filling the buffers.

I've changed it to keep the delay to a minimum by using snd_pcm_update_avail() to calculate how full the buffers are and only update them once they cross a certain threshold. This works fine.

Cheers
James Milne
FilmLight Ltd

On 7 May 2012, at 17:32, Adrian Knoth <adi@drcomp.erfurt.thur.de> wrote:

> On 04/30/2012 06:03 PM, jamesm wrote:
> 
>> Hello all,
> 
> Hi!
> 
>> The latest hdspm driver code from alsa and kernel.org indicates that
>> the HDSPe AIO card has a fixed buffer size of 16384. I've chosen a
>> period size of 1024, which gives me 16 periods.
> 
> Exactly.
> 
>> The issue I have is that whenever I play audio through the hdspm
>> driver, the delay between the hw pointer and sw pointer is always close
>> to the maximum buffer size (approx 16000). This leaves me with a large
>> delay between writing data into the PCM and it coming out of the card.
>> I'd like this to be between 1024 and 2048, I could probably crank the
>> period down further to 512.
> 
> I suggest to try jackd1 and see if you can achieve the desired latency.
> There's a tool jack_iodelay that helps you to measure the round trip
> latency.
> 
> If it works, have a look at the code in drivers/alsa/ how jackd
> configures the device.
> 
> I don't know what happened in alsa-lib between 1.0.17 and 1.0.25 wrt to
> PCM streams, so if in doubt, update that library, too, maybe on a
> different system if you don't want to touch your RHEL-5.5 installation.
> 
>> Does anyone have any suggestions as to why the hdspm driver hw pointer
>> is not following the application pointer more closely?
> 
> The hw pointer is the hw pointer, it's the hardware, not the driver.
> The hardware just cycles through its 16k sample buffer, so it's up to
> the software (read: alsa-lib and/or application) to write to the
> appropriate address.
> 
> It works just fine here on my RayDAT (also has a 16k sample buffer) down
> to 32 samples per period via the MMAP interface.
> 
> 
> Cheers
> 
