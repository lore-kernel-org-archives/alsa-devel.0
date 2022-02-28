Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB72EC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 04:22:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22E9816C6;
	Mon, 28 Feb 2022 05:21:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22E9816C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646022137;
	bh=Gi8FpyN4bsXKnu9lkRdGtfdiKSfRQhLmvMF+SulgXTA=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OKGRS45wBhe++gBgvpfez1xKIeQrrBce0lIZm/skfPcineCI7X5NsqVZGplr+HXfr
	 HslGx/wXDIbXA9bjdJJWu/1UQ8IpOxmSh/XQWakZ85KGMyXzb0EtTvMH7Mr5SU/Arj
	 FZXyLlDKsAOd0Gsol0XtCQiCLdTt8f29xyPBjMbo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90728F80128;
	Mon, 28 Feb 2022 05:21:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53F33F80054; Mon, 28 Feb 2022 05:21:23 +0100 (CET)
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57919F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 05:21:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57919F80125
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay13.hostedemail.com (Postfix) with ESMTP id 5CDB060D10;
 Mon, 28 Feb 2022 04:21:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf16.hostedemail.com (Postfix) with ESMTPA id CF7892000E; 
 Mon, 28 Feb 2022 04:20:35 +0000 (UTC)
Message-ID: <486925d77d6c9f06b7b89e2c575a004bbda5bc3c.camel@perches.com>
Subject: Re: [PATCH v2 2/2] ALSA: core: Remove redundant 'err' variable
From: Joe Perches <joe@perches.com>
To: Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Date: Sun, 27 Feb 2022 20:21:07 -0800
In-Reply-To: <20220228030614.10606-2-tangmeng@uniontech.com>
References: <20220228030614.10606-1-tangmeng@uniontech.com>
 <20220228030614.10606-2-tangmeng@uniontech.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: CF7892000E
X-Stat-Signature: 1n9phyytqiwzrkhid4ude7o4uu41zksi
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+4XlN2/MthucwEh1rUlHXAInh5Juwx+Pc=
X-HE-Tag: 1646022035-405178
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Mon, 2022-02-28 at 11:06 +0800, Meng Tang wrote:
> Return the result from file->f_op->open() directly instead of
> taking this in another redundant variable.
[]
> diff --git a/sound/sound_core.c b/sound/sound_core.c
[]
> @@ -582,13 +582,12 @@ static int soundcore_open(struct inode *inode, struct file *file)
>  		 * We rely upon the fact that we can't be unloaded while the
>  		 * subdriver is there.
>  		 */
> -		int err = 0;
>  		replace_fops(file, new_fops);
>  
>  		if (file->f_op->open)
> -			err = file->f_op->open(inode,file);
> +			return file->f_op->open(inode, file);
>  
> -		return err;
> +		return 0;
>  	}
>  	return -ENODEV;
>  }

Perhaps clearer would be to make the typical return the last statement,
return early and reduce the indentation too.

i.e.:

---
 sound/sound_core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 90d118cd91641..9f2cd6d91a034 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -581,22 +581,20 @@ static int soundcore_open(struct inode *inode, struct file *file)
 			new_fops = fops_get(s->unit_fops);
 	}
 	spin_unlock(&sound_loader_lock);
-	if (new_fops) {
-		/*
-		 * We rely upon the fact that we can't be unloaded while the
-		 * subdriver is there.
-		 */
-		int err = 0;
-		replace_fops(file, new_fops);
+	if (!new_fops)
+		return -ENODEV;
 
-		if (file->f_op->open)
-			err = file->f_op->open(inode,file);
+	/*
+	 * We rely upon the fact that we can't be unloaded while the
+	 * subdriver is there.
+	 */
+	replace_fops(file, new_fops);
 
-		return err;
-	}
-	return -ENODEV;
-}
+	if (!file->f_op->open)
+		return -ENODEV;
 
+	return file->f_op->open(inode,file);
+}
 MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
 
 static void cleanup_oss_soundcore(void)


