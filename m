From: Lee Revell <rlrevell@joe-job.com>
Subject: RE: [ALSA - driver 0001563]: No Sound on
	CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe from
	BIOS...)
Date: Wed, 23 Nov 2005 01:04:07 -0500
Message-ID: <1132725848.10453.1.camel@mindpipe>
References: <D4DBC33C8102AB409C7F44B414D99438015BAB13@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 346B2190
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 07:04:18 +0100 (MET)
In-Reply-To: <D4DBC33C8102AB409C7F44B414D99438015BAB13@bjsmsx402.ccr.corp.intel.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Yang, Libin" <libin.yang@intel.com>
Cc: bugtrack@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-11-23 at 13:55 +0800, Yang, Libin wrote:
> Here is the patch file for 1.0.10. 
> 
> The problem is that in the patch_realtek.c file, it should use
> alc880_idx_to_dac() function in the first 'for' loop, not
> alc880_dac_to_idx() in function alc880_auto_fill_dac_nids().
> 
> Thanks. 

Thank you!

Please provide a Signed-Off-By line with your name and email address,
for example:

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

This is Linux kernel submission policy.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
