From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cmipci CMI8738-MC6 - left channel no sound
Date: Fri, 17 Sep 2010 09:02:51 +0200
Message-ID: <4C93129B.3020802@ladisch.de>
References: <4C89D660.4020705@gmail.com>
	<4C89D9E2.1070008@ladisch.de>	<4C89DCD5.6040806@gmail.com>
	<4C89DF45.5090100@ladisch.de> <4C90DB4C.2040603@gmail.com>
	<4C9204CD.6030400@ladisch.de> <4C920A43.50308@gmail.com>
	<4C920AE1.2050105@ladisch.de> <4C922859.1040709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DEDCE103908
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 09:02:40 +0200 (CEST)
In-Reply-To: <4C922859.1040709@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tom Corner <tom.c.corner@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tom Corner wrote:
> Simple mixer control 'Line-In Mode',0
>   Items: 'Line-In' 'Rear Output' 'Bass Output'
>   Item0: 'Line-In'

OK.

> Simple mixer control 'Mic-In Mode',0
>   Items: 'Mic-In' 'Center/LFE Output'
>   Item0: 'Center/LFE Output'

This should be Min-In (I guess your card doesn't have shared mic-in
jack).

> Simple mixer control 'Phone',0
>   Mono: Playback 7 [100%] [on]

I'd guess you don't need this.

> Simple mixer control 'Four Channel Mode',0
>   Mono: Playback [off]

This might have some effect, but I don't know which setting should be
the correct one.


Regards,
Clemens
