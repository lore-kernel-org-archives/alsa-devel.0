From: "N, Harshapriya" <harshapriya.n@intel.com>
Subject: Question on HDA Audio - resume issue
Date: Tue, 13 Jan 2015 01:53:35 +0000
Message-ID: <6030C7A2BCC49F4EBE16F6749B0C7F1AD424A6@ORSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D7DBF260636
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 02:53:53 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On running a suspend/resume stress test, after a few hundred runs, I see that resume takes a longer time (~40 sec) because of HDA audio (00:03 is the audio device in the system) . HDA audio takes around 35 sec to resume in the following case.

dmesg:

>>>2015-01-11T05:43:39.993107+08:00 kernel: [46300.269994] call 0000:00:03.0+ returned 0 after 35524554 usecs

>>>2015-01-11T05:43:39.993109+08:00 kernel: [46300.270033] PM: Wakeup pending, aborting suspend

Can anyone help understand why would HDA audio take so long to resume sporadically?

-Harsha
