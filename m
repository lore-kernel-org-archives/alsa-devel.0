From: "Le Gall, Louis" <louis.le.gall@intel.com>
Subject: Multiple asoc cards issue?
Date: Fri, 19 Aug 2011 16:34:26 +0000
Message-ID: <7756B9A8AF32424A91D917E64BD63F68011D4F@IRSMSX101.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A66D246BD
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 18:34:31 +0200 (CEST)
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "Gaffie,
	FrancoisX" <francoisx.gaffie@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello

 We are trying to add a new ASOC card in our build that already contains an ASOC card.

 We facing some issue when the second card is registered (calling snd_soc_register_card () ).

 We can see in the log when playing a sound on the first card that second card operations are called.

 In fact, the registration of second card overwrites the operations of the structure soc_pcm_ops of the first card (with the second card operations).
 Looking at the soc-core.c code, this structure is static so that explains the overwrite.

 How can we register several ASOC cards on our platform in that case? Is it a bug or a limitation?

Thanks,
Louis

First card = First card registered during boot process
Second card = second card that is registred during the boot process.


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
