From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emufx.c,1.59,1.60
Date: Sun, 07 Nov 2004 18:11:26 +0000
Message-ID: <418E654E.5000807@superbug.co.uk>
References: <E1CNAGJ-000270-L7@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1CNAGJ-000270-L7@sc8-pr-cvs1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@users.sourceforge.net>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Update of /cvsroot/alsa/alsa-kernel/pci/emu10k1
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv7704/pci/emu10k1
> 
> Modified Files:
> 	emufx.c 
> Log Message:
> Summary: fixed emu10k1_fx8010_code_t structure to be less than 8192 bytes
> 
> This patch fixes emu10k1_fx8010_code_t structure using indirect pointers
> to be less than 8192 bytes to follow the ioctl semantics.
> 
> 
>  
> -static void snd_emu10k1_audigy_write_op(emu10k1_fx8010_code_t *icode, unsigned int *ptr,
> -					u32 op, u32 r, u32 a, u32 x, u32 y)
> +static int snd_emu10k1_audigy_write_op(emu10k1_fx8010_code_t *icode, unsigned int *ptr,
> +				       u32 op, u32 r, u32 a, u32 x, u32 y)
>  {
>  	snd_assert(*ptr < 1024, return);
>  	set_bit(*ptr, icode->code_valid);
> -	icode->code[*ptr    ][0] = ((x & 0x7ff) << 12) | (y & 0x7ff);
> -	icode->code[(*ptr)++][1] = ((op & 0x0f) << 24) | ((r & 0x7ff) << 12) | (a & 0x7ff);
> +	x = ((x & 0x7ff) << 12) | (y & 0x7ff);
> +	y = ((op & 0x0f) << 24) | ((r & 0x7ff) << 12) | (a & 0x7ff);
> +	a = *ptr++ * 2;
> +	if (put_user(x, &icode->code[a + 0]) ||
> +	    put_user(y, &icode->code[a + 1]))
> +		return -EFAULT;
> +	return 0;
>  }
>  
>  #define A_OP(icode, ptr, op, r, a, x, y) \
> @@ -501,83 +511,108 @@


This code breaks Audigy 1/2 support.
1)
+	a = *ptr++ * 2;
should be
+	a = (*ptr)++ * 2;
We want the integer to increase, not the pointer to the integer.

That bug causes the snd-emu10k1 driver to hang during modprobe.

2)
 > +	if (put_user(x, &icode->code[a + 0]) ||
 > +	    put_user(y, &icode->code[a + 1]))
 > +		return -EFAULT;

Will always return -EFAULT on my system. I don't think that is what we 
really want.

James



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
