From: =?gb2312?q?Roc=20Wu?= <cooloney@yahoo.com.cn>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 17:25:22 +0800 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com>
References: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Clemens Ladisch <clemens@ladisch.de> µÄÕýÎÄ£º>
Roc Wu wrote:
> > > # ./aplay -t wav -f U8 -r 22050 alarm.wav
> > > Playing WAVE 'alarm.wav' : Unsigned 8 bit, Rate
> 22050 Hz, Mono
> > > ALSA lib
> pcm_plug.c:727:(snd_pcm_plug_hw_refine_schange)
> > > Unable to find an usable access for 'default'
> > > aplay: set_params:832: Sample format non
> available
> > >
> > > And the kernel driver will dump out the message
> as below:
> > > Badness in aaci_pcm_close at
> sound/arm/aaci.c:404
> 
> This seems to be a bug in the sound driver.
> 
> However, arm/aaci.c is not part of the official ALSA
> distribution.
> AFAIK it's a patch written by Russell King.
> 
> 
> HTH
> Clemens
> 
Yes. Thanks for your replay. Maybe I should send the
mail to arm-linux mailist.

PS. Could you recommend some docs about the ALSA
internals and Low level drivers? There are too many
docs in the www.alsa-project.org, I am an embedded
Linux driver developer, so which one is suit for me?

Thanks a lot
Best Regards


_________________________________________________________
Do You Yahoo!? 
ÏÓÓÊÏäÌ«Ð¡£¿ÑÅ»¢µçÓÊ×ÔÖúÀ©ÈÝ£¡
http://cn.rd.yahoo.com/mail_cn/tag/10m/*http://cn.mail.yahoo.com/event/10m.html


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
