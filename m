Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98170C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:11:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6549D206DB
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nr2vASY/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="X/VcJ7jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6549D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19C841607;
	Wed,  4 Dec 2019 10:10:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19C841607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575450707;
	bh=1WaQ9ue8iE7zj5G8FfUXJix/5nYXBrWhwnNZScZfI54=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nr2vASY/bQylQlmByEcH83B0I+EfS59JXtWowNbBviLRb1F1WmHwcdY/G4UzAHLfe
	 bfTorDj6AQEzTWfGhqn7OsmOnAMLK2ETo9N29fOGAHi8YX1aMAjUOcWLSapymxPQud
	 0LPvA4tlqOuTaUneEHMIKRYwaoLy9jcxRtcUfKbw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9127CF800B4;
	Wed,  4 Dec 2019 10:10:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20A45F801EC; Wed,  4 Dec 2019 10:10:55 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83A91F800B4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 10:10:52 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A38FFA0046;
 Wed,  4 Dec 2019 10:10:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A38FFA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575450651; bh=os9zWSsog2dQj519rttkiDhfkBMkhYLsoYmcu0gi8Uo=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=X/VcJ7jZF3NQEHTu2tsdj/OcZj4d1KCIsnq7EVVouGnow8v4cNJlEpwS4f7Mm95ZC
 t8R1dCWaWI2ohVZd2jcje6yZtZRHOnH4+N+IBhJfhh29ItP4kGZLYrZlYtmmLZT86X
 /vb3VNPmnI9QynQMuxaWsOwTkOpskA0ZTEqGDurI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  4 Dec 2019 10:10:49 +0100 (CET)
To: alsa-devel@alsa-project.org
References: <20191201080449.GA408@workstation>
 <20191204003339.GA2876@workstation>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <d0172374-857c-7663-1afc-acaf1a5d023d@perex.cz>
Date: Wed, 4 Dec 2019 10:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191204003339.GA2876@workstation>
Content-Language: en-US
Subject: Re: [alsa-devel] Restart alsa-gi project as alsa-gobject project
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 04. 12. 19 v 1:33 Takashi Sakamoto napsal(a):
> Hi Jaroslav,
> 
> On Sun, Dec 01, 2019 at 05:04:50PM +0900, Takashi Sakamoto wrote:
>> Since Audio Mini Conference 2018, I continued to work for alsa-gi[1] in
>> my local to integrate toward better I/O libraries. However I realized
>> that its basic design includes some disadvantages to produce useful APIs.
>>
>> I rethink the design and realize it better to wrap each of structures
>> in <sound/asound.h> simply. Then, I restart it as alsa-gobject[2].
>> At present, master branch includes a library, `libalsactl0` for the
>> most of I/O features in ALSA control interface, which is compatible with
>> GObject mechanism and GObject introspection.
>>
>> Jaroslav, would you please delete the alsa-gi repository and fork
>> the master branch from my alsa-gobject repository, then apply enough
>> configurations to the new repository?
>>
>>
>> My repository includes four branches as well for ALSA
>> hwdep/rawmidi/timer/seq interfaces. The most of features in each
>> interface is already available via included libraries but under heavy
>> development.
>>
>> I already start to test them with Python 3 (PyGObject) and they seem
>> work well. I also test them with Rust bindings generated by gtk-rs/gir[3]
>> tool. Near future I also publish Rust crates for further convenience.
>>
>>
>> For your interests, this Python 3 script is a sample to listen one
>> event from ALSA control character device. This simple program is not
>> terminated voluntarily or by sending UNIX signal, thus please generate
>> control event by alsamixer or amixer:
>>
>> ```
>> #!/usr/bin/env python3
>>
>> import gi
>> gi.require_version('GLib', '2.0')
>> gi.require_version('ALSACtl', '0.0')
>> from gi.repository import GLib, ALSACtl
>>
>> class MyCard(ALSACtl.Card):
>>      def __init__(self, card_id, ctx, dispatcher):
>>          super().__init__()
>>          self.open(card_id)
>>
>>          self.create_source().attach(ctx)
>>
>>          self.__dispatcher = dispatcher
>>
>>      def do_handle_disconnection(self):
>>          self.__dispatcher.quit()
>>
>>      def do_handle_elem_event(self, elem_id, events):
>>          # Print the first event and quit event loop.
>>          print(elem_id.get_iface().value_nick,
>>                elem_id.get_device_id(), elem_id.get_subdevice_id(),
>>                elem_id.get_name(), elem_id.get_index(),
>>                events.value_nicks)
>>          self.__dispatcher.quit()
>>
>>
>> ctx = GLib.MainContext.new()
>> dispatcher = GLib.MainLoop.new(ctx, False)
>> card = MyCard(0, ctx, dispatcher)
>>
>> dispatcher.run()
>> ```
>>
>> [1] https://github.com/alsa-project/alsa-gi
>> [2] https://github.com/takaswie/alsa-gobject
>> [3] https://github.com/gtk-rs/gir
> 
> Would I expect your arrangement for this project, or should I continue
> to develop it apart from alsa-project?

You're the only developer for this thus I'll shift the repos in the ALSA 
project on github. You should also write to README that this project is not 
using alsa-lib, thus the extra abstraction interfaces from alsa-lib cannot be 
used. Or do you plan to build gobjects on top of alsa-lib, too?

				Thanks,
					Jaroslav

> 
> 
> Regards
> 
> Takashi Sakamoto
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
