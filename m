From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bug-report: Play Bad Sound After Test Runs for 6
	hrs
Date: Fri, 17 Jul 2015 14:03:01 +0200
Message-ID: <55A8EEF5.9090505@ladisch.de>
References: <55A875C0.7040900@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CDF4F2606CB
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 14:03:03 +0200 (CEST)
In-Reply-To: <55A875C0.7040900@windriver.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yadi <yadi.hu@windriver.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yadi wrote:
> I encounter a strange issue that sound would be bad after running below testcase on intel target over 7 hours.

Is it always after the same time?

What is "bad"?  Which CPU?  What sample rate?

> libsdl1.2-dev 1.2.14-4ubuntu1.1
> libsdl-mixer1.2 1.2.8-6build1
> alsa-lib-1.0.29

Does this also happen if you don't use SDL?


Regards,
Clemens
