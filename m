From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Alsa support for conexant
Date: Fri, 06 Apr 2012 09:09:14 -0500
Message-ID: <4F7EF90A.7020702@linux.intel.com>
References: <1333672211.33483.YahooMailNeo@web124703.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B5982446A
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 16:09:18 +0200 (CEST)
In-Reply-To: <1333672211.33483.YahooMailNeo@web124703.mail.ne1.yahoo.com>
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


> Is there anyway I can get it to output through SPDIF? My other computer that has SPDIF outputs fine using the custom asound.conf so why isn't it working for the lenovo? BTW, I confirmed the SPDIF is not defective  by booting into Windows and testing it.

Can you check if the SPDIF pin is actually enabled (look at 
/proc/asound/cardxx/codec#xx) as OUT. I had a similar problem a long 
time ago on a Lenovo W500, enabling the pin with a one-line verb for the 
connexant 5051 solved the problem.
