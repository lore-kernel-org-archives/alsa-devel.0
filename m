From: =?gb2312?q?Roc=20Wu?= <cooloney@yahoo.com.cn>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 11:04:08 +0800 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607030408.4273.qmail@web15210.mail.bjs.yahoo.com>
References: <20040604091303.19549.qmail@web15207.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040604091303.19549.qmail@web15207.mail.bjs.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi folks:

I don't want to post my question again. But there is
not any response about my question. Maybe I did some
thing wrong about asking question, please let me know.
I will change my method, Thanks a lot.

Please give me some help.

Best Regards


 --- Roc Wu <cooloney@yahoo.com.cn> µÄÕýÎÄ£º> Hi
folks:
> 
> I compiled the alsa-utils. Then I run the aplay on
> my
> board like this:
> 
> # ./aplay -t wav -f U8 -r 22050 alarm.wav
> Playing WAVE 'alarm.wav' : Unsigned 8 bit, Rate
> 22050
> Hz, Mono
> ALSA lib
> pcm_plug.c:727:(snd_pcm_plug_hw_refine_schange)
> Unable
> to find an usable access for 'default'
> aplay: set_params:832: Sample format non available
> 
> And the kernel driver will dump out the message as
> below:
> Badness in aaci_pcm_close at sound/arm/aaci.c:404
> [<c012ead0>] (aaci_pcm_close+0x0/0x90) from
> [<c011333c>] (snd_pcm_release_file+0
> x58/0x8c)
>  r5 = C03852BC  r4 = C03CDC88
> [<c01132e4>] (snd_pcm_release_file+0x0/0x8c) from
> [<c0113764>] (snd_pcm_release+
> 0x8c/0x110)
>  r7 = C03852BC  r6 = C7BF8820  r5 = C0388A00  r4 =
> C0388B18
> [<c01136d8>] (snd_pcm_release+0x0/0x110) from
> [<c0061e1c>] (__fput+0x58/0x138)
>  r7 = C7DEB1E8  r6 = C7FF5260  r5 = C7AFD7FC  r4 =
> C7BF8820
> [<c0061dc4>] (__fput+0x0/0x138) from [<c0060824>]
> (filp_close+0x84/0x90)
>  r7 = 00000001  r6 = C7FEAA00  r5 = 00000000  r4 =
> C7BF8820
> [<c00607a0>] (filp_close+0x0/0x90) from [<c002e700>]
> (put_files_struct+0x8c/0xe8
> )
>  r6 = 00000004  r5 = 00000001  r4 = C7FEAA00
> [<c002e674>] (put_files_struct+0x0/0xe8) from
> [<c002f314>] (do_exit+0x188/0x398)
>  r7 = 00000100  r6 = C00169C0  r5 = C0390360  r4 =
> C00169A0
> [<c002f18c>] (do_exit+0x0/0x398) from [<c002f55c>]
> (next_thread+0x0/0x28)
>  r7 = 00000001  r6 = 00000001  r5 = 402DDE10  r4 =
> 402DDE10
> [<c002f544>] (sys_exit+0x0/0x18) from [<c001e300>]
> (ret_fast_syscall+0x0/0x2c)
> 
> Please give me some hints about the problem.
> 
> Thanks a lot
> Best Regards
> 
> 
> 
>
_________________________________________________________
> Do You Yahoo!? 
> ÏÓÓÊÏäÌ«Ð¡£¿ÑÅ»¢µçÓÊ×ÔÖúÀ©ÈÝ£¡
>
http://cn.rd.yahoo.com/mail_cn/tag/10m/*http://cn.mail.yahoo.com/event/10m.html
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by the new
> InstallShield X.
> From Windows to Linux, servers to mobile,
> InstallShield X is the one
> installation-authoring solution that does it all.
> Learn more and
> evaluate today!
> http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel 

_________________________________________________________
Do You Yahoo!? 
ÏÓÓÊÏäÌ«Ð¡£¿ÑÅ»¢µçÓÊ×ÔÖúÀ©ÈÝ£¡
http://cn.rd.yahoo.com/mail_cn/tag/10m/*http://cn.mail.yahoo.com/event/10m.html


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
