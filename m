From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: fading in/out PCM audio
Date: Tue, 10 Dec 2013 22:50:04 +0100
Message-ID: <52A78C8C.8090907@ladisch.de>
References: <trinity-a01c135b-092e-4212-b844-97d430afd586-1386705593791@3capp-gmx-bs23>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C7481265336
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 22:51:05 +0100 (CET)
In-Reply-To: <trinity-a01c135b-092e-4212-b844-97d430afd586-1386705593791@3capp-gmx-bs23>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mat Gros <pagr2010@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mat Gros wrote:
>  Is it possible to activate fading in/out ramps via the ALSA API?

No.  Change the appropriate mixer control continuously, or modify
the samples.


Regards,
Clemens
