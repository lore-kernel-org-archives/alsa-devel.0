From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: mx31 snd and mc13783 codec status
Date: Tue, 30 Mar 2010 18:23:18 +0200
Message-ID: <4BB22576.1070108@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

For one of our experiments where our robots need to produce sound, I 
would need a sound driver for mx31moboard platform.

I have quickly hacked something based on what you had done for pcm037 
with the MC13783 codec in some of your first sound patches. I know that 
this is not ready for mainline and I'm still struggling to debug my 
code, but I would like to have results quite soon so that my colleague 
could see what sounds (especially regarding to the volume) our system is 
capable to produce.

I would like to know if by any chance you have some updates on this code 
? And do you know if your initial mc13783 codec support coupled with 
mx31 had some limitations ? Our setup is quite straightforward, we have 
direct connection from the mx31 to the mc13783 on a single SSI.

Thanks for your precisions.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
