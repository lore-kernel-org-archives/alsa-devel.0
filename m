Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E49FC46467
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jan 2023 19:48:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4864056A6;
	Mon, 16 Jan 2023 20:48:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4864056A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673898536;
	bh=89XTpp4pKXTQp3RAMlhORG2/4WKMSeaCjvBxaSg27g0=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ghl/EFA5hc30FoFaDr42/RxCM/2zogZfQlpG9FUN4JyOrWI0he7AAIu6oIv+R7kq/
	 TpGAxCyXphZhSo8U1HZ9NzfSnZsp/YBvHlB/JKih5CsXEYihs03+Oz2vy2Dxk3mMy2
	 76ZHZZrtdQsZCq/31ZqZFj7XZ+ix2gRx0tmtpMyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1427F80240;
	Mon, 16 Jan 2023 20:48:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51A0EF8024C; Mon, 16 Jan 2023 20:48:05 +0100 (CET)
Received: from a7-17.smtp-out.eu-west-1.amazonses.com
 (a7-17.smtp-out.eu-west-1.amazonses.com [54.240.7.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42FE2F8023B
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2023 20:48:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42FE2F8023B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key, unprotected) header.d=i2rs.nl header.i=@i2rs.nl
 header.a=rsa-sha256 header.s=2vyqd27h6gu7kyrtaamxo2tr266ggkha
 header.b=hvmmdda1; dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn
 header.b=APPNv2Kx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=2vyqd27h6gu7kyrtaamxo2tr266ggkha; d=i2rs.nl; t=1673898480;
 h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding;
 bh=89XTpp4pKXTQp3RAMlhORG2/4WKMSeaCjvBxaSg27g0=;
 b=hvmmdda1IUY/kZbFcbIvxQ0XHLayW1zFGKbWFJvu12vV0E5fICkA7rw3dN4ISY03
 PcWhvFfAVnlfuFSyIKUAyFrFW2mpEiop5Fl7IE/rFllxxx0OWVxHCunEjFw7Emg52SQ
 SMxwmstt1jm8ni6bljHg/YXbQ4YyWkujQng+CVK8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1673898480;
 h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=89XTpp4pKXTQp3RAMlhORG2/4WKMSeaCjvBxaSg27g0=;
 b=APPNv2KxvBEYADXTrvgQoZ5J1+heqcW2DGbXlfoYI7XDWC/UmtPUgRcd1oAqlQbc
 VYHqez70MBAxBswq/Suf3QbG0mVQubHEg/B6SJDw4c5ADWwsrplzIAwJ8VQhS/3Z0cY
 97ZyBLyHabkburfQVnWWebiAv2QDbaMkSFrm3kMk=
Message-ID: <01020185bc1fd1bd-853c4526-e5d2-428a-a216-1c38763f0b21-000000@eu-west-1.amazonses.com>
Date: Mon, 16 Jan 2023 19:48:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: alsa-devel@alsa-project.org
Content-Language: en-US
From: Jeroen Baten <jbaten@i2rs.nl>
Subject: Question about amidi -l output
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.Qg6RKS0Vh85rXfbGE/RC4HMWYYzuNzzB1o81d5I/9kU=:AmazonSES
X-SES-Outgoing: 2023.01.16-54.240.7.17
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

Hi,

I hope someone can point me in the right direction.

So the Ardour application uses the output of amidi -l to name USB 
devices. In my case I now have 3 devices all named "Boutique MIDI 1", 
although they are 3 different types of synth.

I already added the devices to usb-list and system-hwdb so lsusb shows 
up with correct synth names.

What can I do to make amidi -l show better device names? Where do these 
names come from? What lib or db should I look at to patch and submit?

I hope someone can help me.

Regards,

Jeroen Baten

-- 
Jeroen Baten              | EMAIL :  JBATEN@I2RS.NL
  ____  _  __              | web   :  www.i2rs.nl
   |  )|_)(_               | tel   :  +31 (0)648519096
  _|_/_| \__)              | Frisolaan 16, 4101 JK, Culemborg, the Netherlands

