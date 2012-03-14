From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: dsp-soc: question regarding dsp_add_new_paths
Date: Wed, 14 Mar 2012 09:44:39 +0000
Message-ID: <0C7253583EA2C6438B99011C1263ACEE18ACBF00@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DC1224406
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 10:46:54 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm reversing the dsp-soc code and I have a question regarding the function dsp_add_new_paths:

- Why do you check if (be->dai_link->dynamic) when looking for the FE AIF_IN/OUT, in my comprehension the for FE the dai_link->dynamic = 1?
- For both loops used to find out the FE and BE why do you check the be->dai_link->dynamicsince in the snd_soc_dapm_get_aif loops over all card widget?

Thanks in advance for your answer.

Selma.
 
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
