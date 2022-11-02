Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431D5C4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 14:30:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08AD51663;
	Wed,  2 Nov 2022 15:30:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08AD51663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667399457;
	bh=tOHLHmMofOlZTbe+6xF2pKX7amb+zOzelgG4sULJoNs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9C+UwbYdAiyAlKwwTnwZIvvVGRlwtCu92RIA0sI+mHgwPxr0zTgkRKkcnIRFhoWO
	 wCreA22NMokFsEL9u2xFHPEL6cX8EQFnjkZK5lx2euvPbF8Y0UTi66n7nYrPHrHTFp
	 55PJfRjfg8rhi+dWoqibkH8+bf+d+L/05sqcEmGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79F59F80254;
	Wed,  2 Nov 2022 15:30:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0738FF8026D; Wed,  2 Nov 2022 15:30:03 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A344F80155
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 15:29:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A344F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TjoyjNdT"
Received: by mail-oi1-x236.google.com with SMTP id g10so19361934oif.10
 for <alsa-devel@alsa-project.org>; Wed, 02 Nov 2022 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=La/+Mrbbk7Y3M1/nWjtw6gR6CCcq5pdUafVdNW44l7I=;
 b=TjoyjNdTYTDOT9jYi9jItv24hhydPZ66uT0csHiLAk50HUUTa2JGiZpOR8z0MbARe1
 1HI4sGuKJ8hocl/UxMauEui0blNkwBbtzoUCuqDpnjQF3AmyZmRmgDIbiS5AwJblw7WC
 jiY4Zee6rJTjiL+HiS8b5lLXkY5aULZwMxPyHLCU3ZonFFcqoeDevY3nBII9jcL7eULJ
 CqhqmGAG3p31Nfc2d6Fpy0lIPKnW18HgsS4cTqNGingyHN611xMk9uHYFiG0hciKsBPr
 Rnt8T6uSt8uX6pYzcBi3IkWmpJSmQrmE9sVp4JyT0WuVpbWBliTJqJq8lJtOhfCaZSuM
 /Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=La/+Mrbbk7Y3M1/nWjtw6gR6CCcq5pdUafVdNW44l7I=;
 b=G8CcQFuIQpbo/QD0mijuu9ZJC+u5UYzYSQswQbg936/wGA/4yiZ9jUZafq1g4cIjjq
 t7QzUj9v0LxUzjbSQ6Jo2MKXFUawnVJPVwZvi9IRmA6J2qhDfwzTrdAIUPSHpHBUj8fR
 Iz0jJWwUE22hg3ugWHRnd/7OvKgMhw/sZA5XhdtzvHnqJNLsr2+oZw51PqcPpmEx2ybm
 CQ+8Iq9Fo6FA4MGEAhNhDOajewNvFqX22drhrClagRvPVAivIJiEIpYQeqwUWVlqE3xX
 evYYl/anZMXOPqVPBTBtDY3lEijJKxWDl1BGNUl0Ww8KtTH4BB56ofwQE1uAyoBNM41N
 43hQ==
X-Gm-Message-State: ACrzQf1VmsG8oaTn4LUy9c2f5OGYNauiqLZiG7oo4DEiL8u261BQ30YZ
 nhUNm5tQNVkS+mSZ+xXCFKs=
X-Google-Smtp-Source: AMsMyM4olLvh5721VKRef8viE12z6dwFcozuqP9r44e+WlXAfNcIVObBsG05wsbdIZjbNGhdOUxXAA==
X-Received: by 2002:a05:6808:1a27:b0:354:55e5:9777 with SMTP id
 bk39-20020a0568081a2700b0035455e59777mr21633321oib.267.1667399396452; 
 Wed, 02 Nov 2022 07:29:56 -0700 (PDT)
Received: from geday ([2804:7f2:8006:16ea:99cb:fa89:7dea:3ae])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a9d69d4000000b00661a1a48079sm5033438oto.7.2022.11.02.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 07:29:55 -0700 (PDT)
Date: Wed, 2 Nov 2022 11:29:57 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: David Jaffe <davidajaffe@gmail.com>
Subject: Re: building aplay / arecord
Message-ID: <Y2J+5asFJ7ngsv6c@geday>
References: <CAG74igXPJjnQF6-nbXn2bXywWA0cKpR3cDhYPwg=fKN6J_yZZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG74igXPJjnQF6-nbXn2bXywWA0cKpR3cDhYPwg=fKN6J_yZZA@mail.gmail.com>
Cc: alsa-devel@alsa-project.org
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

On Mon, Oct 31, 2022 at 06:04:26PM -0700, David Jaffe wrote:
> Newbie question...
> 
> I downloaded the alsa-utils source and it says to run ./configure.  But no
> such file exists.  And if I go to aplay and type “make aplay” it can’t find
> a file called “aconfig.h”, which is presumably written by
> ./configure.  What am I missing?

Hi David,

use the gitcompile script. Otherwise read the INSTALL file for manual
instructions.

Thanks,
Geraldo Nascimento
