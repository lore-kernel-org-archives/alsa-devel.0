From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA: Updating Sample Rates in
	sound/core/pcm_native.c
Date: Thu, 19 Apr 2012 19:06:25 +0200
Message-ID: <4F904611.4090308@ladisch.de>
References: <CAEA5kntdSeg+DVwLPtsDiM5Rr3e+AUqYug=S6MacobZSpjXJtQ@mail.gmail.com>	<cad6079b-5d00-49f1-bdec-6e0be5ddce94@email.android.com>	<843008328967385249@unknownmsgid>	<4F902B74.7070603@ladisch.de>
	<CAEA5knsd3NtVCCdufvWm1C6rqLkB2vwarpQVu_TTUw7U5i_JGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BE276104501
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 19:06:36 +0200 (CEST)
In-Reply-To: <CAEA5knsd3NtVCCdufvWm1C6rqLkB2vwarpQVu_TTUw7U5i_JGA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Torres <jeremy.torres@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jeremy Torres wrote:
> Thanks for the quick reply!  So, I followed Takashi's advice and added
> the constraint list for the new sample rates and no longer changed
> pcm.h/pcm_native.c.  I can record/play at the new sample rates;
> however, ALSA is performing rate conversion.  For example, to run at
> 144K, the slave is configured to run 192K, even though my hardware can
> be configured to support 144K.

This sounds like a bug in the driver.

Unfortunately, my crystal ball is out of order, so you have to actually
show the source code for me to be able to help you.


Regards,
Clemens
