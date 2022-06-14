Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B2FC43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 10:53:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFCE71713;
	Tue, 14 Jun 2022 12:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFCE71713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655204022;
	bh=HwyRGxEyzBJkKNFIgwot2I/+k53mipuIgBy7t+RjGag=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jco0Vn7VOwlyVvqqoI51kfqoBAfXzKB6KughezeSR4L41L1FmRBcw3WfvnD7pBF2W
	 IOHRt9I2snqDqnuy2dvZ5499thqXSb1MKK1nanKtwij/tWoHgR5pRo1j3cE6ZV9qYx
	 2ilT23WKnoTn3zecdZAXOUlfthhctOtgMVU2nKLw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F49AF80137;
	Tue, 14 Jun 2022 12:52:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E466F80139; Tue, 14 Jun 2022 12:52:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1368AF800E1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 12:52:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1368AF800E1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655203965639210939-webhooks-bot@alsa-project.org>
References: <1655203965639210939-webhooks-bot@alsa-project.org>
Subject: seq: add boxed structure for event
Message-Id: <20220614105250.6E466F80139@alsa1.perex.cz>
Date: Tue, 14 Jun 2022 12:52:50 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #75 was opened from takaswie:

```
Current implementation provides ALSASeq.EventCntr to handle batch of
sequencer events. Parameters of each event are set/get by public methods
of it with index of event. But it's necesarrily convenient.

This patchset adds boxed structure to express each of the event. Some
public methods are rewritten according to it, with code refactoring. ALSASeq.EventCntr
is largely rewritten with serializer/deserializer for flattened event buffer.

Takashi Sakamoto (12):
  update README
  seq: event-cntr/event-data-queue: obsolete timestamp functions by adding alternatives
  seq: tstamp: remove unused boxed structure
  seq: remove-filter: remove unused error arguments
  seq: enums: rename to tstamp mode
  seq: port-info: rename properties for time stamp
  seq: enums: obsolete ALSASeqSubscribeFlag enumerations
  seq: event: add boxed structure for event
  seq: user-client: add public API to schedule list of events
  seq: user-client: rewrite public API to schedule single event
  seq: event-cntr: rewrite as boxed structure
  seq: event-cntr: add internal API to serialize list of events

 README.rst                   |   18 +-
 samples/seq                  |   96 +-
 src/seq/alsaseq-enum-types.h |   49 +-
 src/seq/alsaseq.h            |    3 +-
 src/seq/alsaseq.map          |  133 +--
 src/seq/event-cntr.c         | 1709 ++--------------------------------
 src/seq/event-cntr.h         |  115 +--
 src/seq/event-data-queue.c   |   52 +-
 src/seq/event-data-queue.h   |   13 +-
 src/seq/event.c              | 1687 +++++++++++++++++++++++++++++++++
 src/seq/event.h              |  112 +++
 src/seq/meson.build          |    4 +-
 src/seq/port-info.c          |  118 ++-
 src/seq/privates.h           |    5 +
 src/seq/remove-filter.c      |   31 +-
 src/seq/remove-filter.h      |   17 +-
 src/seq/subscribe-data.c     |  115 ++-
 src/seq/tstamp.c             |   81 --
 src/seq/tstamp.h             |   24 -
 src/seq/user-client.c        |  153 ++-
 src/seq/user-client.h        |   18 +-
 tests/alsaseq-enums          |   20 +-
 tests/alsaseq-event-cntr     |   60 --
 tests/alsaseq-port-info      |    4 +-
 tests/alsaseq-subscribe-data |    4 +-
 tests/alsaseq-user-client    |    1 +
 tests/meson.build            |    1 -
 27 files changed, 2452 insertions(+), 2191 deletions(-)
 create mode 100644 src/seq/event.c
 create mode 100644 src/seq/event.h
 delete mode 100644 src/seq/tstamp.c
 delete mode 100644 src/seq/tstamp.h
 delete mode 100644 tests/alsaseq-event-cntr
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/75
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/75.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
