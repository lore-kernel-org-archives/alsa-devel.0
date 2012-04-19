From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA: Updating Sample Rates in
	sound/core/pcm_native.c
Date: Thu, 19 Apr 2012 07:56:33 +0200
Message-ID: <cad6079b-5d00-49f1-bdec-6e0be5ddce94@email.android.com>
References: <CAEA5kntdSeg+DVwLPtsDiM5Rr3e+AUqYug=S6MacobZSpjXJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D2BB6104472
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 07:56:40 +0200 (CEST)
In-Reply-To: <CAEA5kntdSeg+DVwLPtsDiM5Rr3e+AUqYug=S6MacobZSpjXJtQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Torres <jeremy.torres@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jeremy Torres wrote:
>I have updated pcm.h in the linux kernel to allow for new sample
>rates.
>However when I try and use the "default" device for the
>sample rates:
>
>1.  For 128000: plug conversion occurs for 128K, but the slave is
>configured to 96K;
>2.  For 144000: plug conversion is attempted at the 176400 rate;

You must keep the symbols in pcm.h and a sound.h
synchronized, and you must not change the value
of any existing symbols.


Regards,
Clemens
