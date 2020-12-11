Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F013C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:24:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C504222257
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C504222257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1929171A;
	Fri, 11 Dec 2020 18:23:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1929171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607707443;
	bh=fjS1OJUyQuPdwvqgdp553fjR4DsD7lkM+b9uDEJxDiQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jbVd/PY2VJUXmt74BM5v/UDNsAiyj9p90eWgQsEggX3BEqJQrzX6o0x5s2WxxbnC5
	 Xhv+W+Utvm332RZlQ8J4ypM+uCpkBq3Vyns36A1kUkLD+JmdJ+IWOZs/Xou29fNg0h
	 XOkg2Znpo0iTS0+IcOYyJX01Y4RoiyisAzicY7GU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 726DBF801D8;
	Fri, 11 Dec 2020 18:23:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53741F8014E; Fri, 11 Dec 2020 18:23:12 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35287F8014E
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 18:23:05 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4E0D8A0042;
 Fri, 11 Dec 2020 18:23:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4E0D8A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607707385; bh=d1AR17qgGUR2Gq0p99fQXPtDyNm7n9atr0o/WdmlZHU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fqXfxKO1XFeGb2pY5Q+pmaSofn3lO+o/RC9286tiAKW9Pmy6iOOFsNtgjchp8hQ2r
 sEykwNIsE62lsaz6CTavJDtAA2E1xfZ/UxgNbCp/a/dCy+E/2TvpIs/r5Fk2fOLJo7
 lRBmlrCuZmfx41NLf5oUObWF4lvHis9ZBgNocrsk=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 11 Dec 2020 18:23:03 +0100 (CET)
Subject: Re: [PATCH] alsactl: Skip restore during the lock
To: Takashi Iwai <tiwai@suse.de>
References: <20201211083804.800-1-tiwai@suse.de>
 <a9bd692e-a55f-f068-b78d-1429a587307e@perex.cz>
 <s5heejwnusm.wl-tiwai@suse.de> <s5hblf0nufm.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <fae14c41-da2e-1bbb-2124-124ae9dd6cdb@perex.cz>
Date: Fri, 11 Dec 2020 18:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <s5hblf0nufm.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

Dne 11. 12. 20 v 18:06 Takashi Iwai napsal(a):
> On Fri, 11 Dec 2020 17:59:05 +0100,
> Takashi Iwai wrote:
>>
>> On Fri, 11 Dec 2020 17:45:45 +0100,
>> Jaroslav Kysela wrote:
>>>
>>> Dne 11. 12. 20 v 9:38 Takashi Iwai napsal(a):
>>>> Currently alsactl-restore tries to initialize the device when an error
>>>> is found for restore action.  But this isn't the right behavior in the
>>>> case where the lock is held; it implies that another alsactl is
>>>> running concurrently, hence you shouldn't initialize the card at the
>>>> same time.  The situation is found easily when two alsactls get
>>>> started by both udev and systemd (note that those two invocations are
>>>> the designed behavior, see /usr/lib/udev/rules.d/78-sound-cards.rules
>>>> for details).
>>>>
>>>> This patch changes load_state() not to handle the initialization if
>>>> the locking fails.
>>>
>>> The operation should serialize in this case (there's limit of 10 seconds which
>>> should be enough to finish the initialization). The state_lock() function
>>> should return -EBUSY when the file is locked (and I'm fine to change the
>>> behaviour from 'init' to 'skip' for this lock state).
>>>
>>> It seems that -EEXIST is returned when the lock file exists, but the
>>> open(file, O_CREAT|O_EXCL, 0644) caller has not enough priviledges to access
>>> this file when another user owns the file.
>>>
>>> But alsactl from /lib/udev/rules.d/90-alsa-restore.rules and
>>> /lib/systemd/system/alsa-restore.service should be run as root, right?
>>
>> Yes, it should be root.
>>
>> I also wondered how EEXIST comes, too.  Maybe it's also the race
>> between the first open(O_RDWR) and the second
>> open(O_RDWR|O_CREAT|O_EXCL)?  If so, it'd be better to go back again
>> to the normal open(O_RDWR)?
> 
> ... something like below
> 
> 
> diff --git a/alsactl/lock.c b/alsactl/lock.c
> index 4a485392b3bd..c1c30f0c5eee 100644
> --- a/alsactl/lock.c
> +++ b/alsactl/lock.c
> @@ -64,6 +64,9 @@ static int state_lock_(const char *file, int lock, int timeout, int _fd)
>  				if (errno == EBUSY || errno == EAGAIN) {
>  					sleep(1);
>  					timeout--;
> +				} if (errno == EEXIST){
> +					/* race at creating a lock, try again */
> +					continue;
>  				} else {
>  					err = -errno;
>  					goto out;

If we don't use the sleep call and the timeout counter, there's endless CPU
busy loop when the root creates the lock file and user wants to access it for
example. It's better to add EEXIST to the previous errno condition.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
