Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FDEC5DF6A
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:25:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1D57601EF;
	Sat, 15 Aug 2026 15:24:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1D57601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786800302;
	bh=rZciTHOfF5lX28xZf4prEBcGyBVa0HpZ8CdGfPok5PU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tcynCzsmNGzKuioxYw89O1dtkVG3ZCmejqqE3Qgn90ZX1ieAwGRLtI/NobH+MmSrS
	 w0gGMqBjtswMGYxR3uBVet5kJ45AJBD/4y4VINSlHtSN7aHe2xvAEJK/F5W7770OvJ
	 Kb5kBeCeBSNg+onGnqsZzOV8KuwdxeeZ5VuhH7Eg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E40AF80623; Sat, 15 Aug 2026 15:24:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B011F8061E;
	Sat, 15 Aug 2026 15:24:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40EC9F8060D; Sat, 15 Aug 2026 15:24:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786800247;
	b=sMWE73SSQrkmffmGXm3UGzePcto0OvR0kLzdBpUyQKYbErjVwn8wZ2cu9i3X2GBB+hyS
	 OwfRTItHr7wPTxj6MiAeeVoLPETa4BX1qoPh1b/FHQmcv/S7U8CY323agMVoaogNQjygN
	 MRwY8E5ZYzdaVEylvzPBavKaYQ7ug0rxFBcfrkkCnGm424dO0XXWEWSBWjxN3vHIIttk7
	 Yw1+i+MVZP0EetqbpeVayMHt/i/bJQbwtivHbfphribY2Ux+3/gyEmfqXYWxsoKuzWF/c
	 9gMllgK5idfvqawj6AgRaQiZs3GA78nYX43Vk74cgnArkJcsZLVtQbIs+fgTsXVd6kQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786800247;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=rZciTHOfF5lX28xZf4prEBcGyBVa0HpZ8CdGfPok5PU=;
	b=Bo9OmJmD3q9YcGXT/hqPMPL6CUi+RJG8LFIBIGTfTEBpAYRSIOTvvVW96wux+vn4KWC6
	 ApdKXcZ8PwlPGoIAnpvHoY7Uodfp0FuR1K84f4QORonO11gimcw3XhySJWCCrhgCh+NoK
	 +I4Nx+VbyvmV8UbBSxWStUDvOHXAObLEBG/EYVqwzBRhXXQ1a8e5FLQLUL9TWUBb49OsO
	 VNAxPQefOHMgnuOU3MHnfn8CATY5sI+yrDnyB8n02UnmYaI1GDRSncx8CYNnuM0WLb5gZ
	 +7NZXjwbo+T1myEAwzP4mLArq6VkrG/GZp4BrxlqujbiLmYe0ivf/OgpvW5pmwTBTjw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E0385F8060A
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2026 15:24:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0385F8060A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cbfd5b51ac3100-webhooks-bot@alsa-project.org>
In-Reply-To: <18cbfd5b51a94700-webhooks-bot@alsa-project.org>
References: <18cbfd5b51a94700-webhooks-bot@alsa-project.org>
Subject: [Question] How to Handle Ump Virtual Input with Endpoint Supporting
 Legacy Midi Only
Date: Sat, 15 Aug 2026 15:24:11 +0200 (CEST)
Message-ID-Hash: RDWVPBZLK2XZABJDAQCIRZJPW5GIQTEU
X-Message-ID-Hash: RDWVPBZLK2XZABJDAQCIRZJPW5GIQTEU
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RDWVPBZLK2XZABJDAQCIRZJPW5GIQTEU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #520 was edited from Logickin-Lambda:

Hello everyone, thank all of you bringing midi 2.0 support into alsa. I have managed to create a simple legacy midi virtual device so that I can send and receive midi from/to the music making software I used (I used SunVox for the experiment); however, while I am messing around the new ump format, I have faced an issue where Legacy Midi device have no awareness to know if the target endpoint uses ump or not, ending with the input callback receive nothing.

The code example is the following. Despite written in zig, all the functions and enums remain identical to the C code:
``` zig
fn createUmpInput(init: std.process.Init) !void {
    var seq: ?*Seq = null;
    const ret = asound.snd_seq_open(&seq, "default", asound.SND_SEQ_OPEN_DUPLEX, 0);
    if (ret < 0) @panic(try std.fmt.allocPrint(init.gpa, "Failed To Open Alsa Midi Sequencer, Error: {d}\n", .{ret}));

    defer std.debug.print("\nseq closed, status: {d}\n", .{asound.snd_seq_close(seq)});

    var buf: [8]u8 = undefined;
    var reader = std.Io.File.stdin().reader(init.io, &buf);
    const interface = &reader.interface;

    // Create an input port, but ump
    const port_id = asound.snd_seq_create_simple_port(
        seq.?,
        "Zig Midi In",
        asound.SND_SEQ_PORT_CAP_WRITE | asound.SND_SEQ_PORT_CAP_SUBS_WRITE,
        asound.SND_SEQ_PORT_TYPE_MIDI_GENERIC | asound.SND_SEQ_PORT_TYPE_APPLICATION | asound.SND_SEQ_PORT_TYPE_MIDI_UMP,
    );

    var future = init.io.async(processUmpEvent, .{seq});
    _ = try interface.takeByte();
    is_active = false;
    future.await(init.io);

    std.debug.print("Created input port: {d}\n", .{port_id});
}

fn processUmpEvent(seq: ?*Seq) void {
    var ev: ?*UmpEvent = null;
    while (is_active) {
        if (asound.snd_seq_ump_event_input(seq.?, &ev) >= 0) {
            std.debug.print("Event type: {d}\n", .{ev.?.type});
        }
    }
}
```

When I open SunVox, although it doesn't support ump, it somehow recognize the `Zig Midi In` device where I "can" send the midi output to the ump endpoint; unsurprisingly, it doesn't work, but this creates a question:

If I have created a virtual input device that is expected to receive ump, while my midi device can only support legacy midi events, what is the common practice to implement a fallback mechanism for the legacy midi device? Or is the virtual device simply ignore the incoming legacy midi format?

I have checked the [documentation](https://www.alsa-project.org/alsa-doc/alsa-lib/seq.html#seq_midi2), but besides:


> In either UMP mode, we use [snd_seq_ump_event_t](https://www.alsa-project.org/alsa-doc/alsa-lib/structsnd__seq__ump__event__t.html) for sequencer event records instead of [snd_seq_event_t](https://www.alsa-project.org/alsa-doc/alsa-lib/structsnd__seq__event__t.html) due to the lack of the data payload size in the latter type.

And 

>For creating a UMP Endpoint in an application, call [snd_seq_create_ump_endpoint()](https://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_middle.html#gae4d6661744be758c5ecd7d0352e90665) with a properly filled [snd_ump_endpoint_info](https://www.alsa-project.org/alsa-doc/alsa-lib/group___raw_midi.html#ga1e37d1b7281227949fe7716f3f129482) data.

I don't seem to find any info regarding how to handle legacy midi device attempting to connect a ump endpoint. Am I missing something? Let me know if further info is needed.

Besides, could anyone suggest any linux midi software that supports the ump format for testing, besides [MIDI2.0Workbench](https://github.com/midi2-dev/MIDI2.0Workbench) since I don't want to install a very specific version of node.js and `yarn` that I have no other application with it?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/520
Repository URL: https://github.com/alsa-project/alsa-lib
