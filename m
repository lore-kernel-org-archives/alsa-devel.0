From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Buffer size calculation based on period size
Date: Fri, 4 May 2018 23:18:28 +0200
Message-ID: <f28d6a20-a0fa-0636-34ae-40e4037daa22@ladisch.de>
References: <CAES_P+_0BFY870-rOW97HRWtW7oa9BeEGNg_T98JiZ5yfTbH_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 26038266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 23:19:13 +0200 (CEST)
Received: from olorin.ladisch.de (x2f7f8bb.dyn.telefonica.de [2.247.248.187])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 28BC85581CC1
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 23:19:13 +0200 (CEST)
In-Reply-To: <CAES_P+_0BFY870-rOW97HRWtW7oa9BeEGNg_T98JiZ5yfTbH_Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

noman pouigt wrote:
> Why ALSA picked period_size of 2042 bytes when the minimum
> period bytes specified is 4084?

ALSA picked a period size of 2042 *frames*.


Regards,
Clemens
