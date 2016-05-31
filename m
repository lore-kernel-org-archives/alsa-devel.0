From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Baytrail audio port problem
Date: Tue, 31 May 2016 07:13:55 -0500
Message-ID: <a27ebee9-fa18-6e60-a689-97e5b52926f1@linux.intel.com>
References: <1811335311.1201572.1464521090270.JavaMail.yahoo.ref@mail.yahoo.com>
 <1811335311.1201572.1464521090270.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0114C2607C8
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 14:13:57 +0200 (CEST)
In-Reply-To: <1811335311.1201572.1464521090270.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alan Paris <alan90000@yahoo.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 5/29/16 6:24 AM, alan Paris wrote:
> Hi everybody,
> well I send this message because I've got a problem with Baytrail audio port (rt5640). I followed the discussion about writing an alsa driver (see it : http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094114.html) and  I tried many solutions (as like that :  https://groups.google.com/forum/#!topic/android-x86/GKBFxCZyxQg ).
>
> Now the system see the Baytrail card audio for speakers but as Michele Curti when I start the system I've got a minute freeze and I haven't got still sound. When I launch dmesg command, I see only those messages :
>
> Baytrail Audio Port: sst: error code = -22
> bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer size = 3840, period size = 480
> Do you know how I can solve this problem and it is possible to operate baytrail audio device with alsa or pulseaudio ?

it looks like you are using an old kernel, the t100 name was removed 
quite a while ago. also without details about your codec we can't help you.
