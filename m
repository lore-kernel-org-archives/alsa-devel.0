From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Mon, 21 Jul 2008 08:51:23 -0400
Message-ID: <9e4733910807210551m7b4ac64qa111557d104c2993@mail.gmail.com>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<20080721094828.GC7083@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id F316710384D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 14:51:24 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so533073ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 05:51:23 -0700 (PDT)
In-Reply-To: <20080721094828.GC7083@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/21/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jul 20, 2008 at 09:47:04PM -0400, Jon Smirl wrote:
>
>  > How about making them work on an array of bytes?
>  >       unsigned int read(struct snd_soc_codec *codec, unsigned int reg, u8 *value);
>  >       int write(struct snd_soc_codec *codec, unsigned int reg, u8* value);
>
>
> This looks like a reasonable way of handling large registers.  We'd need
>  to have a look at the effect on driver code - the main concern would be
>  the effect on drivers for chips with more normally sized registers.
>  Currently they can just call their register access functions with
>  immediate values and it'd be a usability problem if they lost that
>  ability.

I just noticed, the hw read/write routines are already an array of bytes.

typedef int (*hw_write_t)(void *,const char* ,int);
typedef int (*hw_read_t)(void *,char* ,int);



>
>  I think it's most likely that the best way forward would be to have both
>  interfaces in parallel and let drivers use either (or a mix) rather than
>  having the only interface be the large register one.
>
>
>  > If read is sucessful, it returns the number of bytes read. Reading a
>  > non-existent register returns -ENODEV, or you can get other errors
>  > like -EIO when the IO fails.
>
>
> You also need to pass in the size of the buffer being supplied by the
>  caller.
>
>
>  > Instead of u8 I've been using a union in my internal code. We can come
>  > up with better names for the members.
>
>  > typedef struct {
>  >       union {
>  >               u16 s16;
>  >               u8 byte[32];
>
>
> There's a scalability issue here...
>
>
>  > After the low level is changed, the ASOC core needs to be updated to
>  > allow 16 bit shifts and masks up to 64 bits.
>
>
> We should be able support 15 bit masks with a small rearrangement of the
>  existing stuff.
>


-- 
Jon Smirl
jonsmirl@gmail.com
