From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda:
	small cleanups)
Date: Tue, 5 Sep 2006 08:43:52 -0700
Message-ID: <20060905084352.1ced999e.rdunlap@xenotime.net>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de>
	<20060831110436.995bdf93.rdunlap@xenotime.net>
	<20060902231509.GC13031@elf.ucw.cz>
	<20060902213046.dd9bf569.rdunlap@xenotime.net>
	<20060905080813.GE1958@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 9D283245
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Sep 2006 17:40:22 +0200 (MEST)
Received: from midway.site ([71.117.233.155]) by xenotime.net for
	<alsa-devel@alsa-project.org>; Tue, 5 Sep 2006 08:40:18 -0700
In-Reply-To: <20060905080813.GE1958@elf.ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>, pshou@realtek.com.tw, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, 5 Sep 2006 10:08:14 +0200 Pavel Machek wrote:

> Hi!
> 
> > > > So, just this morning I have seen questions and opinions about
> > > > the following that could (or could not) use more documentation
> > > > or codification and I'm sure that we could easily find more,
> > > > but do we want to codify Everything??
> > > > 
> > > > 
> > > > 1.  Kconfig help text should be indented (it's not indented in the
> > > > 	GFS2 patches)
> 
> Chapter 10 speaks about that alread?

OK, good.
I had only looked in Documentation/kbuild/kconfig-language.txt.


> > > > 2.  if (!condition1)	/* no space between ! and condition1
> */
> > > > 3.  don't use C99-style // comments
> > > > 4.  unsigned int bitfield :<nr_bits>;
> 
> Ok.
> 
> > > Looks reasonable to me. Will you do the patch or should I ?
> > 
> > Please (you) go ahead with it.
> 
> Does it look okay?
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> index 6d2412e..d8e51a6 100644
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -46,6 +46,16 @@ used for indentation, and the above exam
>  
>  Get a decent editor and don't leave whitespace at the end of lines.
>  
> +Bitfield variables should be indented like this:
> +
> +	unsigned int foo :1;
> +
> +Avoid extra spaces around ! operator, and do not place spaces around (s.

I would spell out "parentheses".

> +	if (!buffer)
> +
> +is okay, if ( ! buffer ) is just ugly.	
> +
>  
>  		Chapter 2: Breaking long lines and strings
>  
> @@ -280,7 +290,7 @@ int fun(int a)
>  	int result = 0;
>  	char *buffer = kmalloc(SIZE);
>  
> -	if (buffer == NULL)
> +	if (!buffer)
>  		return -ENOMEM;
>  
>  	if (condition1) {
> @@ -316,6 +326,9 @@ When commenting the kernel API functions
>  See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
>  for details.
>  
> +Please do not use C99-style comments, and do not use comments to
                              ^
I would insert:               "// "

> +comment out unused code.
> +

Is there an acceptable way to leave source code in a file but
render it unused?  Like #if 0/#endif or #if BOGUS_SYMBOL/#endif ?


>  		Chapter 9: You've made a mess of it
>  
>  That's OK, we all do.  You've probably been told by your long-time Unix


---
~Randy

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
