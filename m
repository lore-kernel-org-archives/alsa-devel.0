From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Wed, 02 Nov 2011 09:36:04 +0100
Message-ID: <4EB100F4.2000807@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-2-git-send-email-zonque@gmail.com>
	<4EB05D29.7070401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4921B10381C
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 09:36:12 +0100 (CET)
Received: by faao24 with SMTP id o24so177824faa.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Nov 2011 01:36:10 -0700 (PDT)
In-Reply-To: <4EB05D29.7070401@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 11/01/2011 09:57 PM, Clemens Ladisch wrote:
> Daniel Mack wrote:
>> +++ b/sound/usb/card.h
>> +struct snd_usb_endpoint {
>>   	
>> +	struct snd_usb_endpoint *sync_slave;
>
> In theory, there could be more than one slave.

Yes, I thought about this too, but for now, I'd like to leave it to a 
later patch to implement this. This patch set already incorporated too 
many changes.


Daniel
