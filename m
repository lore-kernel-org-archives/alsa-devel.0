From: Computer AG im FSK <cag@fsk-hh.org>
Subject: Re: M-Delta Audiophile 192 (ice1724) Recording
Date: Thu, 31 Jan 2008 23:51:19 +0100
Message-ID: <47A250E7.8040005@fsk-hh.org>
References: <47A24665.80402@fsk-hh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nadir.org (mail.nadir.org [217.114.68.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 52BC2103909
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 23:51:20 +0100 (CET)
In-Reply-To: <47A24665.80402@fsk-hh.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Computer AG im FSK <cag@fsk-hh.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I  forget to mention that we patched
/usr/local/src/alsa-driver-1.0.16rc2/alsa-kernel/pci/ice1712/revo.c
instead of
/usr/local/src/alsa-driver-1.0.16rc2/pci/ice1712/revo.c

because /usr/local/src/alsa-driver-1.0.16rc2/pci/ice1712/revo.c is just
3 lines long or so and looks like including
/usr/local/src/alsa-driver-1.0.16rc2/alsa-kernel/pci/ice1712/revo.c.

Does this matter ?

Greetings, Toast


Computer AG im FSK schrieb:
> Hi,
>
> unfortunately it didn't solve the issue. Same problem: no audio signal
> can be recorded.
> I provided all the information at http://pastebin.ca/886740
>
> If we can't solve the issue this way, maybe we could lend you one of our
> cards ?
>
> Greeting, Toast
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   
