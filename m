From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: HD-Audio: Is it okay to delay resuming codecs when
	resuming from S3?
Date: Tue, 26 Nov 2013 07:16:59 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801419994@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 339E4260864
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 08:17:04 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Takashi
 Iwai (tiwai@suse.de)" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Is it okay to delay resuming codecs when resuming from S3? i.e. skip snd_hda_resume() in azx_resume()?

This would reduce driver resume time from S3. And the codecs will be resumed when being used for the 1st time after S3.

Resuming a codec may cost more than 100ms. So even if we parallel resuming codecs in snd_hda_resume(), driver resume time on some platforms is still a bit long.

Regards
Mengdong
