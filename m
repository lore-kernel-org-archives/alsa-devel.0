From: =?UTF-8?B?SmVhbi1QaWVycmUgQW5kcsOp?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: No jack sense on Intel 82801I / IDT 92HD71B7X in a
 HP dv4
Date: Wed, 17 Jun 2009 08:57:33 +0200
Message-ID: <4A3893DD.6000403@wanadoo.fr>
References: <4A33803F.6050107@wanadoo.fr>
	<d3328e7b0906130656w67e2046dqce261e9b83b4ea6b@mail.gmail.com>
	<4A365A30.8070608@wanadoo.fr>
	<d3328e7b0906150731y70e4bb71ue0662a6f8dd99569@mail.gmail.com>
	<4A36A26C.50801@wanadoo.fr>
	<d3328e7b0906151608v29b6c5d3qf4ec3b84a527dda4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2a.orange.fr (smtp2a.orange.fr [80.12.242.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 27F39103802
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 08:57:37 +0200 (CEST)
In-Reply-To: <d3328e7b0906151608v29b6c5d3qf4ec3b84a527dda4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wael Nasreddine (a.k.a eMxyzptlk)" <mla@nasreddine.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Wael,


Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> boot options maybe irrelevant but maybe not, you should definitely try
>   

They are significant : even on kernel 2.6.30 you have
to use irqpoll, which means all IRQs are analyzed by
sofware, and the system behaves like there were a
single IRQ for all interrupt levels !

Regards

Jean-Pierre

> irqpoll, I also have irqbalance (  http://www.irqbalance.org/ ) on
> boot
>
> Anyway here's my grub entry, don't get scared tho lol ;)
>
> ------ CUT
>     root (hd0,2)
>     kernel (hd0,2)/funtoo/kernel irqpoll keymap=fr dolvm
> crypt_root=/dev/sda4 lvm2root=/dev/mapper/root
> real_root=/dev/Phoenix/Funtoo_Root
> video=uvesafb:ywrap,mtrr:3,scroll:ywrap,1280x800-32
> splash=silent,theme:natural_gentoo fbcon=scrollback:128k
> console=/dev/tty1 real_resume=swap:/dev/Phoenix/Suspend_Swap quiet
>     initrd (hd0,2)/funtoo/initramfs
> ------ CUT
>   
