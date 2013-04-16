From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Can Realtek HD-A codec ALC282 support D3cold?
Date: Tue, 16 Apr 2013 02:37:59 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8384425@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D0C6B2625CB
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 04:38:31 +0200 (CEST)
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

(Sorry to post this message again)

We want to put an idle HD-A codec into D3cold for more power saving and preparation for being power gated. The Realtek ALC282 is used in our test.
Could anyone help to confirm whether ALC282 can support D3cold or not?

I'm told that ALC282 can support D3cold. But my test shows it cannot.

At first, ALC282 HW does not report that it can support D3cold.
Its parameter "Supported Power States" returns 0xc000000f, means it only supports:  EPSS, CLKSTOP, D3hot, D2, D1 and D0.
Is this a just mistake in reporting the bit, or D3cold is not supported all?

Then when I explicitly set the audio function group to D3cold by verb 0x705, and then get its power state after 200ms by verb 0xf05,
The codec response is 0x00000000: No PS-Error, both PS-Act and PS-set is D0. So it seems codec HW does not process the set power state command at all.

Is there someone from Realtek or familiar with ALC282 here can share some information about this issue?

Many thanks
Mengdong
