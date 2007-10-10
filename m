From: william estrada <MrUmunhum@popdial.com>
Subject: Re: chmod with USB sound device?
Date: Wed, 10 Oct 2007 10:42:23 -0700
Message-ID: <470D0EFF.8030105@popdial.com>
References: <470BBB03.7090400@popdial.com> <470CDA7D.1070701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id CEA162455B
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Oct 2007 19:41:56 +0200 (CEST)
In-Reply-To: <470CDA7D.1070701@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, linux-hotplug-devel@lists.sourceforge.net, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Harald,

   I revisited /etc/security/console.perms.d/50-default.perms
and got it to work.
   For the list, I changed:
     In /etc/security/console.perms.d/50-default.perms
> # permission definitions
.
> <console>  0666 <sound>      0666 root
   And
     In /etc/udev/rules.d/50-udev.rules
> KERNEL=="snd/*",		MODE="0666", OWNER="wre00:root"
   Then I did the udevtrigger.

   Then i did the udevtrigger, plugged in my USB sound device and got this:

> [root@laptop wre00]# ls -lrt /dev/snd
> total 0
> crw-rw-rw- 1 wre00 root 116, 2 Oct 10 09:45 timer
> crw-rw-rw- 1 wre00 root 116, 3 Oct 10 09:45 seq
> crw-rw-rw- 1 wre00 root 116, 4 Oct 10 09:45 pcmC0D0p
> crw-rw-rw- 1 wre00 root 116, 5 Oct 10 09:45 pcmC0D0c
> crw-rw-rw- 1 wre00 root 116, 6 Oct 10 09:45 controlC0
> crw-rw-rw- 1 wre00 root 116, 7 Oct 10 10:28 pcmC1D0p
> crw-rw-rw- 1 wre00 root 116, 8 Oct 10 10:28 pcmC1D0c
> crw-rw-rw- 1 wre00 root 116, 9 Oct 10 10:28 controlC1


   I guess both changes are required but it now works.

   Thanks for your time.



William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum



Harald Hoyer wrote:
> william estrada wrote:
>> Hi guys,
>>
>>    I'm trying to run 'chmod' on a USB sound card using 'Hot Plug' udev 
>> support.
>>  From reading, I think I need to update my 
>> '/etc/udev/rules.d/50-udev.rules'?
>> I have made these changes:
>>> # audio devices
.
>>> KERNEL=="snd/*",        MODE="0666"


> 
> You may have a look in pam_console...
> /etc/security/console.perms
> /etc/security/console.perms.d/*
> 
