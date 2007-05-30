From: Alex Pintilie <pintilee@gmx.net>
Subject: Re: Native Instruments - Audio Kontrol 1
 -	snd_usb_caiaq module
Date: Thu, 31 May 2007 01:37:54 +0200
Message-ID: <465E0AD2.70309@gmx.net>
References: <465AE933.60605@gmx.net>	<1180424951.19802.1192252459@webmail.messagingengine.com>
	<s5hr6ozzigh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 2521424536
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 01:37:46 +0200 (CEST)
In-Reply-To: <s5hr6ozzigh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks. After compiling I ran "make install-modules". I found some 
strange behaviour when executing:

# make install-modules

First output line is:

rm -f /lib/modules/2.6.20.3-ubuntu1/misc/snd*.*o 
/lib/modules/2.6.20.3-ubuntu1/misc/persist.o 
/lib/modules/2.6.20.3-ubuntu1/misc/isapnp.o

Then "make" continues to work with /lib/modules/2.6.20.3-ubuntu1/ as 
destination directory. The problem is, I don't know where this directory 
comes from, I never saw it before nor did I install any packages with 
that number. My installed kernels are 2.6.20-16-generic  
2.6.20-16-lowlatency.

alex@****:/lib/modules$ ls
2.6.20-16-generic  2.6.20-16-lowlatency  2.6.20.3-ubuntu1 (<- ?)

--
Alex

Takashi Iwai wrote:
> At Tue, 29 May 2007 09:49:11 +0200,
> Clemens Ladisch wrote:
>   
>> Alex Pintilie wrote:
>>     
>>> snd_usb_caiaq: disagrees about version of symbol snd_pcm_new
>>>       
>> You are trying to use a new version of the snd-usb-caiaq module with
>> some older version of the other sound modules.
>>
>> Install all new modules ("make install-modules"), then unload and reload
>> all snd* modules (or reboot).
>>     
>
> Right.  In many cases, "stop" via alsasound init script doesn't unload
> the all snd-* modules but keeps some of them.  Thus, after upgrading
> the alsa drivers, "rcalsasound restart" doesn't suffice (often).
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
