From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: regarding references taken on platform and codec
	driver modules
Date: Mon, 3 Jan 2011 13:56:31 +0530
Message-ID: <98769532B4BB14429434178695419EAE053BF516B8@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id B3DAF103871
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 09:27:26 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>Hi,
>
>In soc-core.c, I see that try_module_get() is used to get reference count on the
>codec and platform drivers. But I don't see try_module_put() to remove the
>reference count after usage.
>
>Because of this, my reference count on codec and platform driver is never
>reduced and I am not able to do rmmod of these drivers. But I can rmmod the
>machine driver as there are no reference count taken on it.
>
>Is this intentional to avoid rmmod of these modules? Or this is to be fixed
>
Please ignore this email.
>-Harsha
