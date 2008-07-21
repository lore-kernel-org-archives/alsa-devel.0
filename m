From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: RFC: reworking ASOC for large registers
Date: Sun, 20 Jul 2008 21:47:04 -0400
Message-ID: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DDB424560
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 03:47:05 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so454545ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2008 18:47:04 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The current read/write routines:
	unsigned int read(struct snd_soc_codec *codec, unsigned int reg);
	int write(struct snd_soc_codec *codec, unsigned int reg, unsigned int value);

How about making them work on an array of bytes?
	unsigned int read(struct snd_soc_codec *codec, unsigned int reg, u8 *value);
	int write(struct snd_soc_codec *codec, unsigned int reg, u8* value);

If read is sucessful, it returns the number of bytes read. Reading a
non-existent register returns -ENODEV, or you can get other errors
like -EIO when the IO fails.

Write can return bytes written or a negative error code.

Instead of u8 I've been using a union in my internal code. We can come
up with better names for the members.
typedef struct {
	union {
		u16 s16;
		u8 byte[32];
		u16 value[16];
		u32 data[8];
	};
} register_t;

It is easy to change the existing drivers to assign to the var
parameter rather than return from the function.

After the low level is changed, the ASOC core needs to be updated to
allow 16 bit shifts and masks up to 64 bits.

The encoding into 32 bit in the private field would need to be broken
out to use a structure.
	.private_value = (reg_left) | ((shift) << 8)  | \
		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
I think this can be changed inside the macros via a C99 initializer
without effecting existing source.

For a transition the snd_soc_write/snd_soc_read macros could see if
the driver has the old or new form of read/write and use whichever is
defined.

-- 
Jon Smirl
jonsmirl@gmail.com
