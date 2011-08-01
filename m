From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Copy ALSA buffer to the buffer allocated in my
	driver.
Date: Mon, 01 Aug 2011 11:28:08 +0200
Message-ID: <4E3671A8.1090209@ladisch.de>
References: <CAB+ez9vVkGiefO8oQhyUZ+fqRn-vphpZPztu+S=iWsnk73nJLw@mail.gmail.com>	<CAB+ez9tumzPRXcweBWW6EBEM6ySduG36Aue8a_p8_cmubSwopg@mail.gmail.com>
	<CAB+ez9tA3CGxwb=1pge2RB+P97rUzDCNx36kJ1VLLDpFGyRdTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id F3627244DD
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 11:24:41 +0200 (CEST)
In-Reply-To: <CAB+ez9tA3CGxwb=1pge2RB+P97rUzDCNx36kJ1VLLDpFGyRdTg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: `/ET!-i1S!-i <yethish7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

`/ET!-i1S!-i wrote:
> 1. I guess pulse audio inturn calls Alsa and  i want to write a Alsa driver.

But the sound cards on the networked PCs already have drivers.

> The problem i am facing is receiving Alsa buffer to my buffer

Your driver's buffer _is_ the ALSA buffer.

> and updating the buffer position to middle layer.

The hardware position is returned by the pointer callback.
The software position should be of no concern to the driver.

> 2. Is it substream->runtime->dma_area or substream->dma_buffer.area holds
> the audio data? What is the difference between them?

These fields are controlled by your driver, although typically they are
set by ALSA helper functions.

substream->dma_buffer is the preallocated buffer; if your driver doesn't
do preallocation, it is not set.  The actual buffer, if it exists and is
accessible by the CPU from kernel space, is in substream->runtime->dma_area.


Regards,
Clemens
