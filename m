From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Forward/rewind APIs return 0
Date: Mon, 12 May 2008 10:04:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02224F6413@dbde02.ent.ti.com>
References: <010C7BAE6783F34D9AC336EE5A01A0880575F758@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F58424853
	for <alsa-devel@alsa-project.org>;
	Mon, 12 May 2008 06:34:11 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4C4Y4Ls022017
	for <alsa-devel@alsa-project.org>; Sun, 11 May 2008 23:34:09 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m4C4Y304004772
	for <alsa-devel@alsa-project.org>; Sun, 11 May 2008 23:34:03 -0500 (CDT)
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A0880575F758@dbde01.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to use snd_pcm_forward and snd_pcm_rewind APIs in my application. Although they are doing something (I am able to 'hear' the jump), they return me 0, instead of returning me the number of frames.

What could be the problem with the application/driver?

Thanks & Regards,
Anuj Aggarwal
