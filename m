From: Harald Radke <harryrat@postnuklear.de>
Subject: WM8750 utilization
Date: Fri, 15 Aug 2008 18:32:37 +0200
Message-ID: <200808151832.37747.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id F1B8924701
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 18:32:39 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there!

Sorry, if this is the wrong list for this, just tell me if so (and maybe point 
out where to go instead *g*).

I am trying to improve usage of the wm8750 codec on my Loox720 PDA. Its a 
PXA272 device. So far WM8750 driver works quite ok (via I2S), however there 
are some things that are kinda strange.

The Loox720 has a headphone jack, a earpiece and a speaker.

When driving LOUT1/ROUT1, sound goes via headphones, LOUT2/ROUT2 drives the 
earpiece. When setting OUT3 on ROUT1, the speaker plays fine.

Strange: 

- when disabling either LOUT2 or ROUT2 (while the other is enabled), the 
speaker plays the sound (not sure if the earpiece still is active as speaker 
output is much louder, but I think so)

- when disabling ROUT1/LOUT1 with LOUT2/ROUT2 active, the earpiece plays fine, 
however there is still some output on the headphone (really really silently)

- Trying to utilize headphone switch via the WM8750 registers doesn't really 
work ): depending on the polarity bit either one of the OUTs is either not 
muted at all or activated at all.

Any ideas or hints?

Thanks a lot!

Harald Radke
