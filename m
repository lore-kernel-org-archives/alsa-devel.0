From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] pcm: add new 32-bit DSD sample format
Date: Wed, 19 Nov 2014 21:50:30 +0200
Message-ID: <546CF486.7010009@sonarnerd.net>
References: <1410332428-16571-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D7F172604EB
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 20:50:31 +0100 (CET)
In-Reply-To: <1410332428-16571-1-git-send-email-gtmkramer@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry for catching up late on this patch...

On 10.09.2014 10:00, Jurgen Kramer wrote:
> +	FORMATD(DSD_U32_LE, "Direct Stream Digital, 4-byte (x32), little endian, oldest bits in MSB"),

There is bug in this patch. The spec for these formats is, as above says 
"little endian, oldest bits in MSB", however with the iFi iDSD Nano this 
doesn't seem to be the case. Oldest bits are in MSB of the byte, but 
byte order is big endian. IOW, following alone will produce incorrect 
output:

size_t N = 32;
uint32_t x = 0;
while (N--)
{
	x <<= 1;
	x |= nextbit;
}

But if you add __builtin_byteswap32(x) then the output is correct.

I guess this has not been caught because of just memcpy()'ing the 
oldest-bit-in-MSB byte stream to the sample buffer instead of 
constructing the words...


Best regards,

	- Jussi
