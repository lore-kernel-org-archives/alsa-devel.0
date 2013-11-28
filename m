From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: HD-Audio: can msleep in hda_set_power_state() to D3 be
	optional?
Date: Thu, 28 Nov 2013 15:07:48 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141EF7F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B97852651A0
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 16:07:53 +0100 (CET)
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

In hda_set_power_state(), there is a mandatory sleep up to 100ms before setting state to D3.

/* this delay seems necessary to avoid click noise at power-down */
if (power_state == AC_PWRST_D3) {
                   msleep(codec->epss ? 10 : 100);   ... Could this be optional for specific codecs?
                   flags = HDA_RW_NO_RESPONSE_FALLBACK;
}

Some codecs implement their own sleep in patch_ops.suspend() to avoid the noise.
So is it okay to add a codec flag to decide whether the sleep is necessary here?

Thanks
Mengdong
