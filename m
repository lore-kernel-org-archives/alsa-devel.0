From: noman pouigt <variksla@gmail.com>
Subject: DAPM core: update bits in the same i2c operation
Date: Mon, 18 Jan 2016 15:16:39 -0800
Message-ID: <CAES_P+9cv+1YdKB+DwD+nHGLqQVE7iUhh4ZQM_CdWXK=qwLiRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com
 [209.85.160.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A78A7260412
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 00:16:40 +0100 (CET)
Received: by mail-yk0-f173.google.com with SMTP id v14so535958248ykd.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 15:16:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "broonie@kernel.org" <broonie@kernel.org>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hello,

I have two DAC's: left and right and I have made this two as dapm controls.
However left and right dac needs to be enabled in the same I2C write operation.

I can easily make a callback and can enable both left and right bits in one
operation however wondering if ALSA dapm core would have a better way
to handle this.

Where is the relevant code to handle this i.e. merging two dapm widgets
writes to the same register in one? I looked through the code and found
 that every widget gets added in the up and down list which is individually
powered on/off.

Thanks,
