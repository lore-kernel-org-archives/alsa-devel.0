Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4665C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 11:15:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BAF60FDA
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 11:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BAF60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6243C16AC;
	Tue,  8 Jun 2021 13:14:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6243C16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623150925;
	bh=78ccAhFO7kifF3RGq7XD9QjAw3FZnNAFHEg3c4q4Vr8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LeHQolcPxaJQH7JR+l/a5EJrcNkfSvnXNPm5CipXPdhtIulYAPVC+Gl90/7Y8FsrV
	 BVv7MygmxNjkIZMKKD8JRjdxFpilJoZ3UJKPT2eZd8/tl2ywy6QxkVKMPH4yPgbciE
	 0XwQj3Bs9byob5ynsOhvPYcyetvU5v1t0QybNfPg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFA24F801EC;
	Tue,  8 Jun 2021 13:14:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F124FF80218; Tue,  8 Jun 2021 13:14:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 939DCF80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 13:14:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 939DCF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="wzcCpsPY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9C4F6128A;
 Tue,  8 Jun 2021 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623150863;
 bh=78ccAhFO7kifF3RGq7XD9QjAw3FZnNAFHEg3c4q4Vr8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wzcCpsPYYs3ePxgglZVbi7fWGbed0RVk7QwZsstAMyYLXBTVC1cChhk94eH52A0tC
 ze7ESOEINwVdaxMBos5Yth/2jhLL9184tKTevAc7Yb2JX9Hd1sGaH6qM++6mVp513D
 TFi9xOz1YUmQ9yfVYYEu+oltKmPFR+6YoLeSGiM8=
Date: Tue, 8 Jun 2021 13:14:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: USB sound card issues
Message-ID: <YL9RDBUsk23LvHV9@kroah.com>
References: <CAHhAz+haTa8FJep+mokae4O7Gy9zzq2dbPk28fuEH5FO24uTzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+haTa8FJep+mokae4O7Gy9zzq2dbPk28fuEH5FO24uTzw@mail.gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-usb@vger.kernel.org,
 linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Jun 08, 2021 at 04:20:07PM +0530, Muni Sekhar wrote:
> Hi all,
> 
> I am using a USB sound card(snd-usb-audio), and it fails while doing
> the audio recording "arecord: pcm_read:2032: read error: Input/output
> error".
> 
> What could be the problem? and is there a workaround for this?
> 
> $ arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 1: BT_AG [BT_002], device 0: USB Audio [USB Audio]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> 
> $ arecord --device hw:1,0 --channels 1 --format S16_LE --rate 32000_Hz x.wav
> Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 32000 Hz, Mono
> arecord: pcm_read:2032: read error: Input/output error

What kernel version is this, and what other kernel messages are printed
when you plug your device in?

thanks,

greg k-h
