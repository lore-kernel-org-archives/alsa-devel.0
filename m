From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: oxygen: Fix S/PDIF muting
Date: Sun, 28 Jun 2015 20:44:26 +0200
Message-ID: <5590408A.6030100@ladisch.de>
References: <20150628131337.d8077aed73a9851b194bdc30@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 611C8265043
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 20:45:39 +0200 (CEST)
In-Reply-To: <20150628131337.d8077aed73a9851b194bdc30@tuffmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Laurence Darby <ldarby@tuffmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Laurence Darby wrote:
> The S/PDIF output was muted whenever audio wasn't playing which resulted
> in a clicking noise from the DAC when resuming

It indeed appears that there are too many oxygen_clear_bits32() calls.
However, I don't trust the hardware; please confirm that the S/PDIF
output, without an active stream, play zeros and not the last sample.

> Also, the mixer control wasn't actually controlling the S/PDIF output.

Because that is not its purpose to begin with.  >:-)

The mixer control enables copying the "Multichannel" device to the
S/PDIF output.  The "Digital" device has no mute, and takes precedence
over the multichannel device when both are active.


Regards,
Clemens
