From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ALSA: oxfw: configure packet format
 in pcm.hw_params callback
Date: Sun, 23 Jun 2019 23:35:00 +0300
Message-ID: <20190623203500.GN18776@kadam>
References: <20190619101639.GA29913@mwanda>
 <20190622013522.GA14635@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32CE6F8065D
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 22:35:17 +0200 (CEST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5NKUkQb148357
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 20:35:15 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t9c9pb748-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 20:35:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5NKXZxx015760
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 20:35:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2t9acb70w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 20:35:15 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5NKZ6th014256
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 20:35:14 GMT
Content-Disposition: inline
In-Reply-To: <20190622013522.GA14635@workstation>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 22, 2019 at 10:35:23AM +0900, Takashi Sakamoto wrote:
> (sound/firewire/amdtp-stream.c)
> void amdtp_stream_stop(struct amdtp_stream *s)
> {
>     mutex_lock(&s->mutex);
> 
>     if (!amdtp_stream_running(s)) {
>     	mutex_unlock(&s->mutex);
>     	return;
>     }
>     ...
>     fw_iso_context_destroy(s->context);
>     s->context = ERR_PTR(-1);


It might be nice to wrap this assignment in a function call:

void mark_stream_not_running(struct amdtp_stream *s)
{
	s->context = ERR_PTR(-1);
}

Or we could leave it as is...  It doesn't really matter too much.

regards,
dan carpenter
