From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: regarding references taken on platform and
	codec	driver modules
Date: Mon, 3 Jan 2011 21:57:16 +0530
Message-ID: <98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
	<20110103155454.GE6783@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id ED4FB2434C
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 17:27:23 +0100 (CET)
In-Reply-To: <20110103155454.GE6783@opensource.wolfsonmicro.com>
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

>> Is there anything that I am doing wrong here or missing out?
>
>This should all happen automatically based only on the data structures
>in your driver, there shouldn't be anything to miss.
I have created the required data structures in the driver. 
When I do a insmod of machine driver, there are 8 references of platform driver 
taken (4 cpu dai and 4 platform driver) and 4 of codec driver taken
When I do rmmod of machine driver, the references of platform driver and codec 
driver are left at 3. I did a trace back as where all the references are taken and
 where all they are released. I find that 4 references of codec driver and 
 platform driver are taken but only one of them is released.

How do I fix this problem?

-Harsha
