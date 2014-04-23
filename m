From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: How to show hda trace events in a self-built kernel?
Date: Wed, 23 Apr 2014 07:35:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B3F4357@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B89F2650C0
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 09:35:25 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "David
 Henningsson (david.henningsson@canonical.com)" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

How to show hda trace events in a self-built kernel?

With a self-built kernel under Ubuntu 13.04 or 13.10, I enabled hda trace events by
#cd /sys/kernel/debug/tracing/
#echo 1 > events/hda/enable
#echo 1 > events/had_intel/enable

Then I check the codec proc entry and run "cat trace". But I got no output of the hda trace events.

But I switch to the original kernel in Ubuntu 13.04 or 13.10 and repeat the above steps, I can get the output of hda trace events.

Thanks
Mengdong
