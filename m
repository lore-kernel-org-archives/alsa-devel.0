From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Disabling HFL/R outputs in twl4030
Date: Fri, 22 May 2009 03:44:14 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id ABFD624442
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 10:44:27 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

It seems that there is no way to disable handsfree L/R outputs for
twl4030 codec. That means that:
- handsfree amplifiers are turned-on even if we are not interested
  in routing through handsfree
- if the selected input of the handsfree mux is an active DAC
  (streaming) sound will be produced on hf outputs and the only way
  to silence them is routing from a different DAC, which doesn't
  seem like the right solution

Currently, handsfree amplifiers are turned-on when the HandsfreeL/R
muxes are powered by the framework. I was thinking in adding a
dapm switch to select whether or not handsfree amplifiers should
be powered, but the switch probably is not the correct approach to
handle this situation. Maybe a regular kcontrol could be the answer.

-Misa
