From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Thu, 1 Oct 2009 08:39:16 -0500
Message-ID: <6160a5130910010639u11b764bfh92cfb6f6aef671c@mail.gmail.com>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001132417.GA26663@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F69210395E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 15:39:18 +0200 (CEST)
Received: by pzk9 with SMTP id 9so133310pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 06:39:17 -0700 (PDT)
In-Reply-To: <20091001132417.GA26663@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>, alsa-devel@alsa-project.org, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

+/** QOS
+ *
+ * Defines Audio Quality of Service
+ */
+#define SND_QOS_HIFI                   0
+#define SND_QOS_VOICE                  1
+#define SND_QOS_SYSTEM                 2

My $0.02 comment is that I don't know what QOS entails. I have no
issue with all the other defines, but this one isn't quite clear.
What exactly is supposed to happen if I set the QOS to voice? A lower
SNR for voice? A lower latency for voice with a lower group delay? A
lower oversampling ratio? An optimized routing for voice? All of the
above?

+#define SND_SCN_PHONECALL_HANDSET      "phonecall handset"
+#define SND_SCN_PHONECALL_HEADSET      "phonecall headset"
+#define SND_SCN_PHONECALL_BLUETOOTH    "phonecall bluetooth"
+#define SND_SCN_PHONECALL_IP           "phonecall ip"

Same here, this is ambiguous, you can have an IP call over bluetooth.
Which scenario would you use then?
I guess if you want the scenarios to be used by apps in a portable
way, a clearer definition of each scenario is probably needed?
Cheers,
- Pierre
