From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: CS4279 and hw_read_t/hw_write_t
Date: Mon, 21 Jul 2008 11:16:13 -0400
Message-ID: <9e4733910807210816i624618fy8093dc2609e0922d@mail.gmail.com>
References: <9e4733910807210806v4caf49f1ke90cefda07b63579@mail.gmail.com>
	<4884A641.80304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 401212432F
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 17:16:14 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so206514yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 08:16:13 -0700 (PDT)
In-Reply-To: <4884A641.80304@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/21/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>  > From soc/codecs/cs4270.c...
>  >
>  >  *
>  >  * Note that we don't use the hw_write function pointer of snd_soc_codec.
>  >  * That's because it's too clunky: the hw_write_t prototype does not match
>  >  * i2c_smbus_write_byte_data(), and it's just another layer of overhead.
>  >  */
>  >
>  > The prototype doesn't match because you are using
>  > i2c_smbus_write_byte_data() instead of
>  > i2c_master_send()/i2c_master_recv().
>
>
> Should I be using i2c_master_send() instead?  I remember reading somewhere that
>  I should be using the i2c smbus functions if possible.

i2c_smbus... will work with either a smbus controller or an i2c
controller. Inside the routine it decides which type of controller and
then ends up calling i2c_master....

You're on an i2c bus, no need to the overhead.

You'd have to read the CS4270 datasheet in detail to see if can even
be hooked up to an smbus controller. smbus is a subset of full i2c.

>
>
>  --
>  Timur Tabi
>  Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
