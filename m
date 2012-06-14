From: Benjamin Sion <ml_all@circa.be>
Subject: Re: [PATCH] USB: fix gathering of interface
	associations
Date: Thu, 14 Jun 2012 14:23:51 +0200
Message-ID: <4FD9D7D7.3000209@circa.be>
References: <1339525432-22039-1-git-send-email-zonque@gmail.com>
	<4FD9C7D2.8030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo5.mail-out.ovh.net (1.mo5.mail-out.ovh.net [188.165.57.91])
	by alsa0.perex.cz (Postfix) with ESMTP id D62602446F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 14:23:55 +0200 (CEST)
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 83C31FFAC24
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 14:26:40 +0200 (CEST)
In-Reply-To: <4FD9C7D2.8030506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14/06/12 13:15, Daniel Mack wrote:
> On 12.06.2012 20:23, Daniel Mack wrote:
>> TEAC's UD-H01 (and probably other devices) have a gap in the interface
>> number allocation of their descriptors:
> 
> I now got a report from Sergio Tabanelli who tried this patch on real
> hardware, and he confirmed the fix. I added some more people to the
> patch description and copied stable@ as well.

Daniel,

just for information, I only can try the patch on real hardware (TEAC
UD-H01) during this week-end.

btw, thanks a lot for your effort on this patch.

bEN
