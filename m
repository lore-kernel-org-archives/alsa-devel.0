Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85623C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Dec 2021 08:26:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B6A01AEE;
	Sun, 12 Dec 2021 09:25:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B6A01AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639297577;
	bh=PJmohn97XKB2/Xr2iJEeZl22tnsvoJ4bM77AbbW8Xxo=;
	h=Date:To:From:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kXoSmreaQVRLsLusy5uX1Sz8/RngjkeTYyDkuCCH/mHyrkFP7blF8xHcqwdoBv7VN
	 N+1FczzVcThOdfy2TfS7dJQiCWQZrXpWjXDbEQHB/xyVIOpnpcVpgTiaeKbCEU46fN
	 Up8akreMnDMac6duTwXkIw11KcUo06txKoLyz6Rc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B3B2F80520;
	Sun, 12 Dec 2021 09:23:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DC27F804BD; Sat, 11 Dec 2021 19:19:36 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5630F80059
 for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2021 19:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5630F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ox8hFGdz"
Received: by mail-wr1-x42d.google.com with SMTP id v11so20173642wrw.10
 for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2021 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:content-language:to:cc:from
 :subject:content-transfer-encoding;
 bh=9NDT879wS/nwGa0+oPAPDSKpJbWbahGU+iiAATt/+Qw=;
 b=ox8hFGdzrGUxFRAtJ+X3KI0hZUXChXbLC+TT/m5cBV3sRKz1/JL7UOtu6kysjfKnqQ
 9amV5+M0y3YyWWGTmf/o0C3MKwUNJquXgi0pndUuq2ixxFe3GMdwP8nnoUL9YjKLJXhS
 connbw7WpcTO4oiVDHhnM9WXpqnQw7gff0TMbYZXxnrGRld7+TWkUfd3Ll9OJqs8oeCG
 dyfq2IHPmSnP5ZDgEfbPbDIyPKvBjC6rNn+SHWiLzqMuETGtsZhKgdfhqyKOjl47zuaW
 A04vLdfIDxH8WBd1Rno9bksHWV7+YOk+bLJniDFowXvclBqfax7uXhhJXbtg833XqC/Q
 IjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:from:subject:content-transfer-encoding;
 bh=9NDT879wS/nwGa0+oPAPDSKpJbWbahGU+iiAATt/+Qw=;
 b=aNctLjoM0z3/iNkGlqhnjfqlmi+EdWLIhBBNsfaA+9BKhxSTYYBLMUeHV22Q7Lw94f
 VF4a8bLSoJITaFms5CVx9OwyvK5c0nagmfviJJs9scoFwcHinD93wfaVLLLhaQywkDma
 MAiOaEXgwW+ocBF6bK+E0xVA9d+IOg0VaxQhGKBFtmQmIOUf3uEGH09dY+c0xkLNdbwk
 aBwBi0GHwI71WJbwHTrQk4M6ugGJJzO9usoEWce9OOpQl2K1lxF4J8XcRZB9OsFX8dbd
 ixJ1ylo3V7eGeCz8a2lRxm2Pd2fgQTIqJkjRPMjYJ92tl/NdMj84SSb97Z2h5qwpmtNz
 QQpQ==
X-Gm-Message-State: AOAM531mosGxTqjYzrGUEFgnf3Woo96GjE5IFChxlV5CipKZW1IUJna0
 6vMgf63Z3T784vRj5OF6WUs=
X-Google-Smtp-Source: ABdhPJxw3iZyjzTstiCTL2RognPOfsmpt7Ucfo0D+Ovgg9T0j4z0vfgm+JRtNsf/LMJhWyfsTs9zBg==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr21013002wrj.554.1639246771916; 
 Sat, 11 Dec 2021 10:19:31 -0800 (PST)
Received: from [192.168.0.209]
 (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
 by smtp.googlemail.com with ESMTPSA id h18sm6062833wre.46.2021.12.11.10.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Dec 2021 10:19:31 -0800 (PST)
Message-ID: <fbae9be5-c847-0b6b-f755-312a2af1e285@gmail.com>
Date: Sat, 11 Dec 2021 18:19:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: ALSA: drivers: opl3: assignment of a pointer that is not used,
 probable bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 12 Dec 2021 09:23:26 +0100
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi,

static analysis with scan-build has found an assignment to vp2 that is 
never used in function snd_opl3_note_on(), 
sound/drivers/opl3/opl3_midi.c as follows:

         if (instr_4op) {
                 vp2 = &opl3->voices[voice + 3];
                 if (vp->state > 0) {
                         opl3_reg = reg_side | (OPL3_REG_KEYON_BLOCK +
                                                voice_offset + 3);
                         reg_val = vp->keyon_reg & ~OPL3_KEYON_BIT;
                         opl3->command(opl3, opl3_reg, reg_val);
                 }
         }

sound/drivers/opl3/opl3_midi.c:399:3: warning: Value stored to 'vp2' is 
never read [deadcode.DeadStores]
                 vp2 = &opl3->voices[voice + 3];
                 ^     ~~~~~~~~~~~~~~~~~~~~~~~~

I suspect that references to vp in this if block should be to vp2, but 
I'm unsure if that is for all references or not, hence I'm reporting 
this issue.

Coln
