From: Timur Tabi <timur@freescale.com>
Subject: Re: CS4279 and hw_read_t/hw_write_t
Date: Mon, 21 Jul 2008 10:07:45 -0500
Message-ID: <4884A641.80304@freescale.com>
References: <9e4733910807210806v4caf49f1ke90cefda07b63579@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id B83FA2438D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 17:07:48 +0200 (CEST)
In-Reply-To: <9e4733910807210806v4caf49f1ke90cefda07b63579@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> From soc/codecs/cs4270.c...
> 
>  *
>  * Note that we don't use the hw_write function pointer of snd_soc_codec.
>  * That's because it's too clunky: the hw_write_t prototype does not match
>  * i2c_smbus_write_byte_data(), and it's just another layer of overhead.
>  */
> 
> The prototype doesn't match because you are using
> i2c_smbus_write_byte_data() instead of
> i2c_master_send()/i2c_master_recv().

Should I be using i2c_master_send() instead?  I remember reading somewhere that
I should be using the i2c smbus functions if possible.

-- 
Timur Tabi
Linux kernel developer at Freescale
