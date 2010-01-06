From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: capturing data from the microphone
Date: Wed, 6 Jan 2010 11:39:16 +0000
Message-ID: <20100106113916.GA26282@rakim.wolfsonmicro.main>
References: <4B1E66DD.1000906@heig-vd.ch> <20091208145104.GC9018@sirena.org.uk>
	<4B1F4617.1020307@heig-vd.ch>
	<20091209104502.GC17832@opensource.wolfsonmicro.com>
	<4B44617B.2030002@heig-vd.ch>
	<20100106103937.GA25344@rakim.wolfsonmicro.main>
	<4B446974.1090205@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57068103821
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 12:39:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B446974.1090205@heig-vd.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Garnier <marc.garnier@heig-vd.ch>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 06, 2010 at 11:44:04AM +0100, Marc Garnier wrote:
> OK, well, I work on a custom device platform based on an Atmel
> at91sam9261. I wrote an alsa driver composed of 2 files

CCing in the list and Sedji, who wrote the driver.  Please also try
avoid top posting - Linux lists generally intersperse replies with the
relevant context from the original message since it makes mails much
more legible.

> But when I want to record a pcm stream I have this error:
> # arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
> arecord: pcm_read:1629: read error: Input/output error

[With an AT91 in slave mode...]
> and actually no interrupt occur and I
> wonder why...

Can you see clocks on the audio interface?  Have you checked that the
pins on the processor are configured to route the signals to the correct
IP block?
