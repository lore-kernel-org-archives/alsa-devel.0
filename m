From: Justin Cormack <justin@street-vision.com>
Subject: Re: Why does Alsa sometimes not find the HDSP 9652?
Date: 21 Dec 2003 15:21:13 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072020074.8692.20.camel@lotte.street-vision.com>
References: <1071937305.5565.1.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1071937305.5565.1.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-12-20 at 16:21, Mark Knecht wrote:
> Wizard root # /etc/init.d/alsasound start
>  * Loading ALSA drivers...
>  * Loading: snd-seq-oss
>  * Loading: snd-pcm-oss
>  * Loading: snd-mixer-oss
>  * Loading: snd-via82xx
>  * Loading: snd-hdsp
> /lib/modules/2.4.20-gentoo-r9/kernel/sound/pci/rme9652/snd-hdsp.o:
> init_module: 
> No such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including inva
> lid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg

You may indeed find more information in the syslog.

Probably the memory allocator has failed to load. You need to load it as
early as possible after boot. Might be worth moving sound start to
earlier in boot.

It might be something else, but without syslog cant help.

Justin




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
