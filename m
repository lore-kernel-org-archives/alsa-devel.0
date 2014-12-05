From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DMA buffer alignment
Date: Fri, 05 Dec 2014 12:34:58 +0100
Message-ID: <54819862.9030509@ladisch.de>
References: <CAOQ7t2b5Rr6OjpQQ8uvwQ+7O2RL=tTKyjWG1HSJuOc3X4-NDag@mail.gmail.com>	<548089E3.4060105@ladisch.de>
 <CAOQ7t2ZNARpAyfr_q9qjsbvbxQU2-AFgQC6aY=Tuurm3dhWPUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1CE7726059C
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 12:35:31 +0100 (CET)
In-Reply-To: <CAOQ7t2ZNARpAyfr_q9qjsbvbxQU2-AFgQC6aY=Tuurm3dhWPUA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Carlo Caione wrote:
> let's say that our application sends uning snd_pcm_writei() a buffer
> that is exactly 64 bytes and that our hwoff (appl_ofs)

The hardware and the software (appl) pointers are independent.

> is pointing to a memory location 0 in the DMA area.
> When this buffer is taken from the SoC sound driver, the .copy
> callback writes this buffer as follow: 32 bytes (left channel) to
> memory locations from *hwoff to *hwoff+31, and 32 bytes (right
> channel) for *hwoff+32 to *hwoff+63.
> Problem is when my buffer is not multiple of 64 bytes, for example if
> the buffer size is < 64. If I receive a buffer of lenght 32 byte than
> my DMA memory is filled as follows: 16 bytes from *hwoff to *hwoff+15
> and 16 bytes from *hwoff+32 to *hwoff+47, leaving 32 bytes in the
> block not initialized.

These bytes are written later.  And if they are not written fast enough,
you get an underrun.  This is no difference from any other sound card.

> In some way I should always guarantee that the size of the buffer
> passed to my .copy callback is multiple of 64 bytes.

The .copy callback just copies samples to memory; this is possible
with any alignment.

The DMA runs asynchronously, and uses its own pointer.


Regards,
Clemens
