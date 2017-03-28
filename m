From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Overlay 24bit data 32bit slots
Date: Tue, 28 Mar 2017 16:43:29 +0200
Message-ID: <fde2fe9c-3fb3-29dd-243a-afdb10865bac@ladisch.de>
References: <BN3PR0701MB16888D7C159EED2A635A647AA2330@BN3PR0701MB1688.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9243B26583C
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:43:30 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id E82B75581CA2
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:43:29 +0200 (CEST)
In-Reply-To: <BN3PR0701MB16888D7C159EED2A635A647AA2330@BN3PR0701MB1688.namprd07.prod.outlook.com>
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

Ed McNicholas wrote:
> I am interfacing with a dsp that we have programmed and there are only
> options for slot widths of 16 or 32 bits but we are using a 24 bit
> data format.

24-bit samples are typically handled by padding them to 32 bits and then
pretending they are 32 bits.

> When I record using
>
> arecord -v -f S24_LE -r 48000 -t wav -c4 /home/nyquist/test.wav
>
> I get garbage

S24_LE is a very unusual format (24 bits padded to 32 bit with a zero
byte as the most significant byte), and not supported by the .wav file
format.  Try a raw file instead.  And the normal format for 24-bit
samples would be S32_LE.


Regards,
Clemens
