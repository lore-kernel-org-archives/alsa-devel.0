From: Goncalo Pinheira <goncalopp@gmail.com>
Subject: Re: emu10k1, midi on audigy platinum ex
Date: Tue, 29 Mar 2011 16:21:26 +0100
Message-ID: <4D91F8F6.2010002@gmail.com>
References: <4D91B8D7.2000504@gmail.com> <4D91CEF9.4030009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sapo.pt (relay3.ptmail.sapo.pt [212.55.154.23])
	by alsa0.perex.cz (Postfix) with SMTP id 072F32441D
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 17:21:31 +0200 (CEST)
Received: from unknown (HELO cp.goncalopp.com)
	(as11656677@sapo.pt@[85.240.138.230])
	(envelope-sender <goncalopp@gmail.com>)
	by mta13 (qmail-ptmail-1.0.0) with AES256-SHA encrypted SMTP
	for <alsa-devel@alsa-project.org>; 29 Mar 2011 15:21:28 -0000
Received: from [192.168.0.5] (pekkala [192.168.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cp.goncalopp.com (Postfix) with ESMTPSA id D5241A0E9
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 16:21:19 +0100 (WEST)
In-Reply-To: <4D91CEF9.4030009@ladisch.de>
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

On 29-03-2011 13:22, Clemens Ladisch wrote:
> Goncalo Pinheira wrote:
>> I've noticed midi in (DIN connector) on an audigy platinum ex doesn't work.
> IIRC you have to set the "enable_ir" module parameter.
>
>
> Regards,
> Clemens
Just checking, that means I should put "snd-emu10k1 enable_ir=1" on 
/etc/modprobe.d/alsa-base.conf, correct? Should something be output on 
dmesg? (please excuse the ignorance, I still don't know much about alsa)
If that's it, it's still not working, not with that parameter nor with 
the aforementioned patch.
The only way it starts working is by rebooting to windows and then back 
to linux. I'm guessing the emu needs some kind of initialization?
