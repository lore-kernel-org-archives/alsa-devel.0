Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E4BC2BA2B
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 11:59:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D500A20753
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 11:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V+VXmVja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D500A20753
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35499852;
	Thu,  9 Apr 2020 13:58:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35499852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586433549;
	bh=lN0ygn5/dZV15ujZ+cj198BWBGcIIuhtubMMzPu5z2A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+VXmVja/wqMRQ2f/Q2xSenhKMiYHB2BWONuPvy6bjIfhhK4k6D8D0QoM8pCX19E4
	 cEuncdJmV3J7VBKGgz1FOInZTBfv/Au2npuwGDzPKLpvDlG5RVBXJfIr8e7KgTX/Hk
	 UcmgoH7fWXgpUyX48FXdmcE3R6eAkv9v/gOOfiHc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0503F801D8;
	Thu,  9 Apr 2020 13:58:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79F6FF801DA; Thu,  9 Apr 2020 13:58:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 633C0F80107
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 13:58:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 633C0F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1586433493470645905-webhooks-bot@alsa-project.org>
References: <1586433493470645905-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: Add shared library to operate ALSA rawmidi character
 device
Message-Id: <20200409115817.79F6FF801DA@alsa1.perex.cz>
Date: Thu,  9 Apr 2020 13:58:17 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #16 was opened from takaswie:

This patchset is to add a new library, libalsarawmidi, to operate ALSA rawmidi
character device. This library is compatible with GObject Introspection.

ALSA rawmidi interface is designed to transfer MIDI messages. Userspace
application operate ALSA rawmidi character device for incoming/outgoing
transmission. The transmission line is abstracted as substream. One
character device is associated to several substreams. The application can
indicate subdevice to select a substream or a pair of substreams from them.

The library has ALSARawmidi.StreamPair to operate the character device.
Userspace application call ALSARawmidi.StreamPair.open() to open the chracter
device, select subdevice and attach the substreams to the device. After the
call, data transmission already starts. The application can call
ALSARawmidi.StreamPair.write_to_substream() to transfer MIDI message bytes.

The application can also call ALSARawmidi.StreamPair.read_from_substream()
to receive MIDI message bytes, but this call can be blocked till any
messages are actually received and available as a default. For polling,
GSource which ALSARawmidi.StreamPair.create_source() returns is useful.
The application can use it for GMainContext/GMainLoop. When any message
is available, ALSARawmidi.StreamPair emits 'handle-messages' GObject signal.
The application register its handler to the signal in advance, then
process the messages.

ALSARawmidi.StreamPair has the other methods to drain/drop running
substream:
 - ALSARawmidi.StreamPair.drain_substream() 
 - ALSARawmidi.StreamPair.drop_substream() 

ALSARawmidi.StreamPair has more methods to return GObject-derived objects
for information/status/parameters of substream:
 - ALSARawmidi.StreamPair.get_substream_info()
 - ALSARawmidi.StreamPair.get_substream_status() 
 - ALSARawmidi.StreamPair.set_substream_params() 

The library includes global method to query information about rawmidi:
 - ALSARawmidi.get_rawmidi_sysname()
 - ALSARawmidi.get_rawmidi_devnode()
 - ALSARawmidi.get_device_id_list()
 - ALSARawmidi.get_subdevice_id_list()
 - ALSARawmidi.get_substream_info()

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/16
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/16.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
