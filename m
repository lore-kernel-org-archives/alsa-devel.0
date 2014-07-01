From: Josh Lehan <alsa@krellan.com>
Subject: Re: [PATCH - alsa-utils 1/5] Adding amidicat
 subdirectory to SUBDIRS
Date: Tue, 01 Jul 2014 00:30:16 -0700
Message-ID: <53B26388.7030103@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-2-git-send-email-alsa@krellan.com>
 <53B14ADA.50202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www7.pairlite.com (www7.pairlite.com [64.130.10.17])
 by alsa0.perex.cz (Postfix) with ESMTP id F29CC264F03
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:30:21 +0200 (CEST)
In-Reply-To: <53B14ADA.50202@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/30/2014 04:32 AM, Clemens Ladisch wrote:
> Josh Lehan wrote:
>> +++ b/Makefile.am
>> -SUBDIRS = include alsactl alsaucm utils m4 po
>> +SUBDIRS = include alsactl alsaucm utils m4 po amidicat
> 
> This belongs into the seq directory.

OK, good idea, I'll move it there.

Josh
