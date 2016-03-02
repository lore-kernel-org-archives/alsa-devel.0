From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Compute Stick baytrail audio problem
Date: Wed, 2 Mar 2016 11:25:25 -0600
Message-ID: <56D72205.7020007@linux.intel.com>
References: <20160219203900.GA5202@monopoli.naic.edu>
 <56C8826A.3030303@linux.intel.com> <56CBCB86.8040601@gmail.com>
 <20160223143443.GA22458@monopoli.naic.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A0ECF265357
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 18:25:34 +0100 (CET)
In-Reply-To: <20160223143443.GA22458@monopoli.naic.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Giacomo Comes <comes@naic.edu>, Toyo Abe <toyo.abe@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> After some investigation, I found some problems on the driver and fixed a few of
>> them. I pushed the fix to my github. I hope it might help you.
>>    https://raw.githubusercontent.com/toyoabe/baytrailaudio/fix-underrun/hdmi_audio_20150319.patch
>>
>> Best Regards,
>> -toyo
>
> Hi,
> that was it!. I added your changes and now the audio works. I'm happy.
> I got finally every subsystem of the Compute Stick working.

If anyone is interested, I ported the code to v4.4, it seems to work on 
the Baytrail Compute stick w/ Ubuntu.

https://github.com/plbossart/sound/commits/baytrail-stick-rebase-4.4

Testers welcome, next steps are to add the CherryTrail parts, rebase to 
the drm-nightly-build branch and start talking upstream changes.
