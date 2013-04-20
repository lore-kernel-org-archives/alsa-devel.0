From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM buffering ussues ( or probably the lack of
 understanding )
Date: Sat, 20 Apr 2013 10:46:33 +0200
Message-ID: <517255E9.1020903@ladisch.de>
References: <5172401E.8020708@quicknet.nl> <51724930.3020406@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id B972C26509E
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 10:46:53 +0200 (CEST)
In-Reply-To: <51724930.3020406@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, marcelg <marcelsbox@quicknet.nl>
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
> pcm_pointer goes from 0 to buffer_size.

Actually, from 0 to buffer_size - 1.


Regards,
Clemens
