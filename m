From: Tim Sheridan <tghs@tghs.net>
Subject: Compress offload: DSP buffer timestamp passing
Date: Wed, 3 Feb 2016 11:49:17 +0000
Message-ID: <CAELVyQdcVoTV7iGxA=jJGQToobpePB-Fk-scvUbOFBf36X2B+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've been working on the Imagination Technologies AXD (audio DSP)
compress offload driver. One of the features of the DSP is scheduled
playback of audio using timestamps (that are obtained by an
application from userspace). A current problem with the compress
offload API is that there's no "blessed" way to get these timestamps
from tinycompress through to our compress offload driver.

Currently, I've added a SNDRV_COMPRESS_ENCODER_PTS value to the
sndrv_compress_encoder enum, and exposed this with an API in
tinycompress, handling this in my driver to pass it to the DSP. Does
this sound like a reasonable approach to go about adding compress
offload API support for this? Or is there some other part of the ALSA
API which would be more appropriate to use instead of this?

Cheers,
Tim
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
